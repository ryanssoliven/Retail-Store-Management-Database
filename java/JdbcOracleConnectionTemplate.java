import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.*;
import java.io.*;
       
/**
* This program demonstrates how to make database connection with Oracle

*
*/
public class JdbcOracleConnectionTemplate {

  private static Connection conn1 = null; 
  private static String[] queries = null;
       
  public static void main(String[] args) {
    conn1 = null;
    line();
    
    createQueries();
    
    try {
      //establish connection
      Class.forName("oracle.jdbc.OracleDriver");
      String dbURL1 = "jdbc:oracle:thin:username/password@oracle.scs.ryerson.ca:1521:orcl";
  	  conn1 = DriverManager.getConnection(dbURL1);
      if (conn1 != null) {
        System.out.println("Connected to database successfully.");
      }	
  		/*	
  	  String query = "select NAME, NUM from TESTJDBC";
  							
  	  try (Statement stmt = conn1.createStatement()) {
  
        ResultSet rs = stmt.executeQuery(query);
  
  			
  			while (rs.next()) {
  				String name = rs.getString("NAME");
  				int num = rs.getInt("NUM");
  				System.out.println(name + ", " + num);
  			}
      } catch (SQLException e) {
  			System.out.println(e.getErrorCode());
      }
      */
    } catch (ClassNotFoundException ex) {
      ex.printStackTrace();
    } catch (SQLException ex) {
      ex.printStackTrace();
    } 
    
    
    selectOption();
    
    
    //terminate connection
    try {
      if (conn1 != null && !conn1.isClosed()) {
        conn1.close();
        System.out.println("Disconnected from database.");
      }
    } catch (SQLException ex) {
      ex.printStackTrace();
    }
  }
			
  
              
              
              
  private static void selectOption(){
    String in = "";
    String select = "";
    Scanner s = new Scanner(System.in);
    while(true){
      line();
      System.out.println("Select an option:\n1) create tables\n2) populate tables\n3) drop tables\n4) perform queries\nq) quit out");
      in = s.nextLine();
      if(in.equals("q")){
        return;
      }
      else if(in.equals("1")){
        createTables();
      }
      else if(in.equals("2")){
        populateTables();
      }
      else if(in.equals("3")){
        dropTables();
      }
      else if(in.equals("4")){
        selectQuery();
      }
      else{
        System.out.println("Enter an accepted integer or q to quit.");
      }   
    } 
  }
  
  private static void createQueries(){
    try{
      queries = concatFile("./queries.txt");
    }
    catch (FileNotFoundException f){
      System.out.println("query script file not found");
    }
  }
  
  private static void createTables(){
    System.out.println("Creating tables...");
    try (Statement stmt = conn1.createStatement()) {
      String[] query = concatFile("./createTables.txt");
      for(int i = 0; i < query.length; i++){
        try{
          //System.out.println(query[i]);
          stmt.executeQuery(query[i]);
        } catch(SQLException e){
		      //System.out.println(e.getErrorCode());
          //System.out.println(e.getMessage());
        }
      }	
      System.out.println("Done!");
    } catch (SQLException e) {
		  //System.out.println(e.getErrorCode());
    } catch (FileNotFoundException f){
      System.out.println("create table script file not found");
    }
  }
  
  private static void populateTables(){
    System.out.println("Populating tables...");
    try (Statement stmt = conn1.createStatement()) {
      String[] query = concatFile("./populateTables.txt");
      for(int i = 0; i < query.length; i++){
        try{
          //System.out.println(query[i]);
          stmt.executeQuery(query[i]);
        } catch(SQLException e){
		      //System.out.println(e.getErrorCode());
          //System.out.println(e.getMessage());
        }
      }	
      System.out.println("Done!");	
    } catch (SQLException e) {
		  //System.out.println(e.getErrorCode());
    } catch (FileNotFoundException f){
      System.out.println("population table script file not found");
    }
  }
  
  private static void dropTables(){
    System.out.println("Dropping tables...");
    try (Statement stmt = conn1.createStatement()) {
      String[] query = concatFile("./dropTables.txt");
      for(int i = 0; i < query.length; i++){
        try{
          //System.out.println(query[i]);
          stmt.executeQuery(query[i]);
        } catch(SQLException e){
          //System.out.println(e.getErrorCode());
        }
      }	
      System.out.println("Done!");
    } catch (SQLException e) {
		  //System.out.println(e.getErrorCode());
      //System.out.println(e.getMessage());
    } catch (FileNotFoundException f){
      System.out.println("drop table script file not found");
    }
  }
           
  private static void selectQuery(){
    String in = "";
    Scanner s = new Scanner(System.in);
    while(true){
      line();
      System.out.println("1) Relevant promotions for item 49827669 if transaction is made at time 2020-06-13 10:23:00");
      System.out.println("2) All transactions made at any store with credit or debit");
      System.out.println("3) All managers with their number of subordinates fewer than 4");
      System.out.println("4) All products found exclusively at one store location");
      System.out.println("5) List of products being sold at a retail store and being held at Warehouse Location '90 Penny Boulevard' AND Warehouse Location '43 Farside Road'");
      System.out.println("6) Count warehouses and employees working at each store");
      System.out.println("7) Count the number of sales of each product per store location");
      System.out.println("8) List all warehouses that are authorized to exchange inventory with the store located at '104 Main Street' and has the product 'blue jeans'");
      System.out.println("q) quit");
     
      in = s.nextLine();
      if(in.equals("q")){
        return;
      }
      else if(in.equals("1")){
        String query = queries[0];
        try (Statement stmt = conn1.createStatement()) {
          ResultSet rs = stmt.executeQuery(query);
    			while (rs.next()) {
    				String promotion = rs.getString("Promotion");
    				int percent = rs.getInt("Percent");
    				System.out.println("Promotion: " + promotion + " Percent: " + percent);
    			}
        } catch (SQLException e) {
          if(e.getErrorCode() == 942){
            System.out.println("Relevant data does not exist; populate the database.");
          }
    			System.out.println(e.getErrorCode());
        }
      }
      else if(in.equals("2")){
        String query = queries[1];
        try (Statement stmt = conn1.createStatement()) {
          ResultSet rs = stmt.executeQuery(query);
    			while (rs.next()) {
    				String id = rs.getString("ID");
            String method = rs.getString("PaymentMethod");
    				System.out.println("Transaction " + id + " Payment method: " + method);
    			}
        } catch (SQLException e) {
          if(e.getErrorCode() == 942){
            System.out.println("Relevant data does not exist; populate the database.");
          }
    			System.out.println(e.getErrorCode());
        }
      }
      else if(in.equals("3")){
        String query = queries[2];
        try (Statement stmt = conn1.createStatement()) {
          ResultSet rs = stmt.executeQuery(query);
    			while (rs.next()) {
    				String name = rs.getString("FullName");
            int sub = rs.getInt("subordinates");
    				//int num = rs.getInt("NUM");
    				System.out.println(name + " has " + sub + " subordinates.");
    			}
        } catch (SQLException e) {
          if(e.getErrorCode() == 942){
            System.out.println("Relevant data does not exist; populate the database.");
          }
    			System.out.println(e.getErrorCode());
        }
      }
      else if(in.equals("4")){
        String query = queries[3];
        try (Statement stmt = conn1.createStatement()) {
          ResultSet rs = stmt.executeQuery(query);
    			while (rs.next()) {
    				String loc = rs.getString("StoreLocation");
            String prod = rs.getString("ProductID");
            String name = rs.getString("Name");
    				//int num = rs.getInt("NUM");
    				System.out.println(name + " #" + prod + " at store " + loc);
    			}
        } catch (SQLException e) {
          if(e.getErrorCode() == 942){
            System.out.println("Relevant data does not exist; populate the database.");
          }
    			System.out.println(e.getErrorCode());
        }
      }
      else if(in.equals("5")){
        String query = queries[4];
        try (Statement stmt = conn1.createStatement()) {
          ResultSet rs = stmt.executeQuery(query);
    			while (rs.next()) {
            String id = rs.getString("ID");
    				String name = rs.getString("Name");
    				//int num = rs.getInt("NUM");
    				System.out.println(name + " #" + id);
    			}
        } catch (SQLException e) {
          if(e.getErrorCode() == 942){
            System.out.println("Relevant data does not exist; populate the database.");
          }
    			System.out.println(e.getErrorCode());
        }
      }
      else if(in.equals("6")){
        String query = queries[5];
        try (Statement stmt = conn1.createStatement()) {
          ResultSet rs = stmt.executeQuery(query);
    			while (rs.next()) {
    				String loc = rs.getString("addressid");
            int countW = rs.getInt("WareHouses#");
            int countE = rs.getInt("employees#");
    				//int num = rs.getInt("NUM");
    				System.out.println("Store #" + loc + " Warehouses: " + countW + " Employees: " + countE);
    			}
        } catch (SQLException e) {
          if(e.getErrorCode() == 942){
            System.out.println("Relevant data does not exist; populate the database.");
          }
    			System.out.println(e.getErrorCode());
        }
      }
      else if(in.equals("7")){
        String query = queries[6];
        try (Statement stmt = conn1.createStatement()) {
          ResultSet rs = stmt.executeQuery(query);
    			while (rs.next()) {
            String loc = rs.getString("STORELOCATION");
    				String name = rs.getString("Name");
            int count = rs.getInt("#of transactions");
    				//int num = rs.getInt("NUM");
    				System.out.println("Store #" + loc + " sold " + count + " units of " + name);
    			}
        } catch (SQLException e) {
          if(e.getErrorCode() == 942){
            System.out.println("Relevant data does not exist; populate the database.");
          }
    			System.out.println(e.getErrorCode());
        }
      }
      else if(in.equals("8")){
        String query = queries[7];
        try (Statement stmt = conn1.createStatement()) {
          ResultSet rs = stmt.executeQuery(query);
    			while (rs.next()) {
    				String warehouse = rs.getString("warehouse");
            int n = rs.getInt("Quantity");
    				//int num = rs.getInt("NUM");
    				System.out.println("Warehouse #" + warehouse + " " + n + " units.");
    			}
        } catch (SQLException e) {
          if(e.getErrorCode() == 942){
            System.out.println("Relevant data does not exist; populate the database.");
          }
    			System.out.println(e.getErrorCode());
        }
      }
      else{
        System.out.println("Enter an accepted integer or q to return to previous menu.");
      }
    }
  }
  
  private static String[] concatFile(String path) throws FileNotFoundException{
    String content = "";
    String[] contents;
    Scanner s = new Scanner(new File(path));
    while(s.hasNextLine()){
      content = content + s.nextLine() + " ";
    }
    
    contents = content.split(";");
    for (int i = 0; i < contents.length; i++){
      contents[i] = contents[i] + "";
    }
    return contents;
  }
  
  private static void line(){
    System.out.println("---------------------------------------------------------------");
  }
}
