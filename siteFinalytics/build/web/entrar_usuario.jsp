<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>login</title>
        <link rel="stylesheet" href="log.css">
    </head>
    <body>
        <div class="login-container">
            <%
                String nome = request.getParameter("nome");
                String senha = request.getParameter("senha");

                Connection conecta = null;
                PreparedStatement st = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco2", "root", "");
                    String sql = "SELECT * FROM usuarios WHERE nome=? AND senha=?";
                    st = conecta.prepareStatement(sql);
                    st.setString(1, nome);
                    st.setString(2, senha);
                    rs = st.executeQuery();

                    if (rs.next()) {
                        out.print("<p>Login bem-sucedido</p>");
                    } else {
                        out.print("<p>Usuário e/ou senha inválidos</p>");
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    out.print("<p>Ocorreu um erro: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (st != null) st.close();
                    if (conecta != null) conecta.close();
                }
            %>
            <a href="log.html">Voltar ao Login</a>
        </div>
    </body>
</html>
