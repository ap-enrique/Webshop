import java.sql.Connection; // För att representera en anslutning
import java.sql.DriverManager; // För att registrera och ska en anslutning
import java.sql.SQLException; // För att hantera fel vid databasoperationer

public class DatabaseConnection {

    private static final String URL = "jdbc:mysql://localhost:3306/webshop"; // databas adress plats och databasnamn
    private static final String USER = "root"; // Användarnamn för databas administratör
    private static final String PASSWORD = "admin"; // Lösenord kopplat till USER

    // Metod för att upprätta en anslutning till databasen
    public static Connection getConnection() throws SQLException {
        try {
            // Laddar MySQL-drivrutinen
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) { // Om det uppstår ett fel
            System.out.println("MySQL JDBC Driver not found.");
            e.printStackTrace();    // Skriv ut felet
            return null;
        }

        // Returnerar anslutningen
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Stäng anslutningen
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {  // Om det uppstår ett fel
                e.printStackTrace(); // Skriv ut felet
            }
        }
    }
}
