<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            // Receber os dados digitados no formulario log.html
            String nome, email, senha;
            nome = request.getParameter("nome");
            email = request.getParameter("email");
            senha = request.getParameter("senha"); 

            // Fazer a conexão com o Banco de Dados
            try{
            Connection conecta; 
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco2", "root", "");
            //Inserir os dados na tabela produto do vanco de dados aberto
            st = conecta.prepareStatement("INSERT INTO usuarios VALUES(?,?,?)");
            st.setString(1, nome);
            st.setString(2, email);
            st.setString(3, senha);
            st.executeUpdate();
            out.print("Cadastrado com sucesso");
            } catch (NumberFormatException ex){
              out.print("Erro " + ex.getMessage());
            } catch (SQLException ex){
              out.print("Erro " + ex.getMessage());            
            }
        %>
        
    </body>
</html>
