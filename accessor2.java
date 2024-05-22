package accessor;

public class accessor1 {

	//Getters (Sql Commands)
	//store
	public String getStore(String Store_ID) {
		String Storeoutput = "";
		String query;
		boolean success;
	
		try (Statement stat = conn.createStatement()) {
			query = String.format("SELECT Total_Row, Total_Col FROM `Store` WHERE Store_ID = '%s'", Store_ID);
			
			
			success = stat.execute(query);
			if (success) {
				ResultSet result = stat.getResultSet();
				Storeoutput = ResultSet result;	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return Storeoutput;
		
	//shelf	
	public String getShelf(String Shelf_ID) {
		String Shelfoutput = "";
		String query;
		boolean success;
		
		try (Statement stat = conn.createStatement()) {
			query = String.format("SELECT Col_No, Row_No FROM `Shelf` WHERE Shelf_ID = '%s'", Shelf_ID);
				
				
			success = stat.execute(query);
			if (success) {
				ResultSet result = stat.getResultSet();
				Shelfoutput = ResultSet result;	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return Shelfoutput;

	//product	
	public String getProduct(String Product_ID, String Shelf_ID) {
		String Productoutput = "";
		String query;
		boolean success;		
		
		try (Statement stat = conn.createStatement()) {
			query = String.format("SELECT Product_Name, Shelf_ID FROM `Product` WHERE Product_ID = '%s'", Product_ID);
				
				
			success = stat.execute(query);
			if (success) {
				ResultSet result = stat.getResultSet();
				Productoutput = ResultSet result;	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return Productoutput;

	//review	
	public String getReview(String Product_ID) {
		String Reviewoutput = "";
		String query;
		boolean success;
			
		try (Statement stat = conn.createStatement()) {
			query = String.format("SELECT Review_Info FROM `Product_Review` WHERE Product_ID = '%s'", Product_ID);
					
					
			success = stat.execute(query);
			if (success) {
				ResultSet result = stat.getResultSet();
				Reviewoutput = ResultSet result;	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return Reviewoutput;
	
	//promotion	
	public String getPromotion(String Product_ID) {
		String Promotionoutput = "";
		String query;
		boolean success;
				
		try (Statement stat = conn.createStatement()) {
			query = String.format("SELECT Discount, Promotion_Date FROM `Product_Promotion` WHERE %s", Product_ID);
						
						
			success = stat.execute(query);
			if (success) {
				ResultSet result = stat.getResultSet();
				Promotionoutput = ResultSet result;	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return Promotionoutput;	
		
	//history	
	public String getHistory(String Product_ID) {
		String Historyoutput = "";
		String query;
		boolean success;
					
		try (Statement stat = conn.createStatement()) {
			query = String.format("SELECT Price_History, Recorded_Time FROM `Product_Price_History` WHERE Product_ID = '%s'", Product_ID);
				
			
			success = stat.execute(query);
			if (success) {
				ResultSet result = stat.getResultSet();
				Historyoutput = ResultSet result;	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return Historyoutput;		
		
	//Customer	
	public String getCustomer(String Customer_ID) {
		String Customeroutput = "";
		String query;
		boolean success;
						
		try (Statement stat = conn.createStatement()) {
			query = String.format("SELECT User_ID, Purchase_History FROM `Customer` WHERE Customer = '%s'", Customer_ID);
				
			
			success = stat.execute(query);
			if (success) {
				ResultSet result = stat.getResultSet();
				Customeroutput = ResultSet result;	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return Customeroutput;	
		
	//Intersection	
	public String getIntersection(String Intersection_ID) {
		String Intersectionoutput = "";
		String query;
		boolean success;
							
		try (Statement stat = conn.createStatement()) {
			query = String.format("SELECT Store_ID, Row_No, Shelfcol FROM `Intersection` WHERE Intersection = '%s'", Intersection_ID);
					
			
			success = stat.execute(query);
			if (success) {
				ResultSet result = stat.getResultSet();
				Intersectionoutput = ResultSet result;	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return Intersectionoutput;	
		
	//Setters (Sql Commands)
	//updateProduct
	public void updateProduct(String Shelf_ID, String Product_ID) {
		String query = String.format("UPDATE `Product` SET `Shelf_ID`='%s' WHERE Product__ID = '%s'", Shelf_ID, Product_ID);
			
		try (Statement stat = conn.createStatement()){
			stat.execute(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	//insertProduct	
	public void insertProduct(String Product_ID) {
		String query = String.format("INSERT INTO `Product`(`Product_ID`, `Shelf_ID`, `Product_Name`, `Product_Price`, `Product_Description`) VALUES ('%s', `%s`, `%s`, %d,`%s`)", Product_ID, Shelf_ID, Product_Name, Product_Price, Product_Description);
				
		try (Statement stat = conn.createStatement()){
			stat.execute(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	//updatePromotion
	public void updatePromotion(String Product_ID, INT Discount, String Promotion_Date) {
		String query = String.format("UPDATE `Promotion` SET `Discount`= %d, `Promotion_Date = `%s`` WHERE Product__ID = '%s'", Discount, Promotion_Date, Product_ID);
					
		try (Statement stat = conn.createStatement()){
			stat.execute(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
	//insertPromotion
	public void insertPromotion(String Product_ID, INT Discount, String Promotion_Date) {
		String query = String.format("INSERT INTO `Promotion`(`Product_ID`, `Discount`, `Promotion_Date`) VALUES ('%s', %d,`%s`)", Product_ID, Discount, Promotion_Date);
				
		try (Statement stat = conn.createStatement()){
			stat.execute(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	//storeinfo
	public String getStoreInfo(String Store_ID) {
		String StoreInfooutput = "";
		String query;
		boolean success;
								
		try (Statement stat = conn.createStatement()) {
			query = String.format("SELECT Total_Row, Total_Col, Exit, Entrance FROM `Store` WHERE Store_ID = '%s'", Store_ID);
						
				
			success = stat.execute(query);
			if (success) {
				ResultSet result = stat.getResultSet();
				StoreInfooutput = ResultSet result;	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return StoreInfooutput;	
		
	//intersections
	public String getItscs(String Intersection_ID) {
		String Itscsoutput = "";
		String query;
		boolean success;
									
		try (Statement stat = conn.createStatement()) {
			query = String.format("SELECT Row_No, Col_No FROM `Intersection` WHERE Intersection_ID = '%s'", Intersection_ID);
							
					
			success = stat.execute(query);
			if (success) {
				ResultSet result = stat.getResultSet();
				Itscsoutput = ResultSet result;	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return Itscsoutput;
	
	//shelves
	public String getShelves(String Store_ID) {
		String Shelvesoutput = "";
		String query;
		boolean success;
										
		try (Statement stat = conn.createStatement()) {
			query = String.format("SELECT Col_No, Row_No, AdjacentWalkway FROM `Shelf` WHERE Store_ID = '%s'", Store_ID);
								
						
			success = stat.execute(query);
			if (success) {
				ResultSet result = stat.getResultSet();
				Shelvesoutput = ResultSet result;	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return Shelvesoutput;	
		
	//targetshelves
	public String getTargetShelves(String Product_ID) {
		String TargetShelvesoutput = "";
		String query;
		boolean success;
											
		try (Statement stat = conn.createStatement()) {
			query = String.format("SELECT Shelf_ID FROM `Product` WHERE Product_ID = '%s'", Product_ID);
									
							
			success = stat.execute(query);
			if (success) {
				ResultSet result = stat.getResultSet();
				TargetShelvesoutput = ResultSet result;	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return TargetShelvesoutput;	
}