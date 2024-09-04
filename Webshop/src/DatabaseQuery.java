import java.sql.*;

public class DatabaseQuery {

    public static void main(String[] args) {
        // SQL-frågan
        String sql_query_string = "SELECT Kund.Name " +
                "FROM Kund " +
                "JOIN Orders ON Kund.ID = Orders.Kund_ID " +
                "JOIN Order_Item ON Orders.ID = Order_Item.Orders_ID " +
                "JOIN Produkt ON Order_Item.Produkt_ID = Produkt.ID " +
                "JOIN Brand ON Produkt.Brand_ID = Brand.ID " +
                "WHERE Produkt.Name = 'Byxor' " +
                "AND Produkt.Storlek = '38' " +
                "AND Produkt.Color = 'Svart' " +
                "AND Brand.Name = 'SweetPants'";

        Connection conn = null; //Tom variabel för databaskopplingen

        try {
            // Anropa DatabaseConnection.java för att skapa en anslutning
            conn = DatabaseConnection.getConnection();

            // Kontrollera att anslutningen är framgångsrik
            if (conn != null) {
                // Förbered och kör SQL-frågan
                PreparedStatement pre_State = conn.prepareStatement(sql_query_string); //Prepare Statement för att inte använda SQL injektioner.
                ResultSet result = pre_State.executeQuery(); // i result variabel finns svaret från det Query.

                // Skriva ut resultatet
                while (result.next()) { //Itererar över varje rad från block variebel result. I detta fall är en kolummn tabell.
                    String kundNamn = result.getString("Name"); // Hämtar kundens namn från kolumnen "Name".
                    System.out.println("Kundens namn: " + kundNamn);
                }

                // Stäng resurserna
                result.close();
                pre_State.close();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Stäng anslutningen
            DatabaseConnection.closeConnection(conn);
        }
    }
}
