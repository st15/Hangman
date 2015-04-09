package com.lios.hangman.data
{
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	
	import starling.events.EventDispatcher;
	
	/**
	 * Used for connecting to the database and returning random words.
	 */
	internal class DatabaseConnector extends EventDispatcher
	{
		private var conn:SQLConnection;
		// Няма голямо значение, защото е id е индекс,
		// но все пак, броят на думите във всяка таблица е хардкоднат, за да се спести още една SQL заявка :  SELECT MAX(id) FROM table_name.
		// Ако се редактира БД, трябва да се промени кода.
		private const wordCount:Object = {"words":13368, "bgtowns":257, "countries":192, "capitals":197};
		
		public function DatabaseConnector()
		{
			// open Connection to SQLite database
			var dbFile:File = File.applicationDirectory.resolvePath(DatabaseConstants.PATH); 
			
			var encryptionKey:ByteArray = new ByteArray(); 
			encryptionKey.writeUTFBytes(DatabaseConstants.KEY); 
			
			conn = new SQLConnection();
			try {
				conn.open(dbFile, SQLMode.READ, false, 1024, encryptionKey); 
			} 
			catch (error:SQLError) { 
				trace("sql error " + error.message + error.details);
			}
		}
		
		/**
		 * Loads random words.
		 * 
		 * @param tableName word category name
		 * @param number of words to load
		 * 
		 * @return An array of word objects, eg [{"hint":"Европа","name":"Испания"}, {"hint":"Азия","name":"Китай"}]
		 */
		public function loadWords(tableName:String, wordsCount:uint):Array
		{
			trace("load words");
			try {
				// start a transaction 
				conn.begin(); 
				var statement:SQLStatement = new SQLStatement();
				statement.sqlConnection = conn; 
				
				var sql:String = "SELECT name,hint FROM " + tableName + " WHERE id IN(";
				
				for (var i:int = 0; i < wordsCount; i++)
				{
					if (i != 0)
						sql += ",";
					// generate random id
					sql += String( Math.floor(Math.random() * wordCount[tableName]) + 1 );
				}
				sql += ")";
				statement.text = sql;
				
				statement.execute(); 
				// commit the transaction 
				conn.commit(); 
				
				return statement.getResult().data;
			} 
			catch (error:SQLError) {
				trace("sql error " + error.message + error.details);
				return null;
			}
		}
	}
}