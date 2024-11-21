package com.skillIt;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/data")
public class SearchServlet extends HttpServlet {

    // Method to handle POST request and parse JSON response
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            // Set response type as JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            // Get the request body parameters (optional, can be used to filter data, etc.)
            String requestBody = readRequestBody(request);
            JSONObject jsonRequest = new JSONObject(requestBody);
            String filterParam = jsonRequest.optString("filter", ""); // Example parameter

            // Connect to MySQL and retrieve data
            try (Connection connection = DatabaseUtil.getConnection()) {
                // Example SQL query (you can adjust this based on your needs)
                String query = "SELECT Emp_Id, Emp_Name FROM Employee WHERE Emp_Name LIKE ?";
                try (PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setString(1, "%" + filterParam + "%");
                    try (ResultSet resultSet = statement.executeQuery()) {
                        JSONArray jsonArray = new JSONArray();

                        while (resultSet.next()) {
                            JSONObject jsonData = new JSONObject();
                            jsonData.put("id", resultSet.getInt("id"));
                            jsonData.put("name", resultSet.getString("name"));
                            jsonArray.put(jsonData);
                        }

                        // Send the JSON response
                        PrintWriter out = response.getWriter();
                        out.print(jsonArray.toString());
                        out.flush();
                    }
                }
            } catch (SQLException e) {
                // Handle SQL exception (return an error response in JSON)
                JSONObject errorResponse = new JSONObject();
                errorResponse.put("error", "Database connection error");
                response.getWriter().write(errorResponse.toString());
            }
        }
        catch(JSONException e){e.printStackTrace();}
    }

    // Method to read the request body as a string
    private String readRequestBody(HttpServletRequest request) throws IOException {
        StringBuilder stringBuilder = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                stringBuilder.append(line);
            }
        }
        return stringBuilder.toString();
    }
}
