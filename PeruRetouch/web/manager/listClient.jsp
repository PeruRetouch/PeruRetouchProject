<%@page import="java.util.List"%>
<%@page import="pe.com.peruretouch.business.base.OperacionEnum"%>
<%@page import="pe.com.peruretouch.entity.User"%>
<%@page import="pe.com.peruretouch.business.UserBusiness"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    if (session.getAttribute(ConstantesWeb.USER_HOME) == null) {
        response.sendRedirect("../index.jsp");
    } else {
        UserBean userBean = (UserBean) session.getAttribute(ConstantesWeb.USER_HOME);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Client List</title>
        <link rel="icon" type="image/png" href="../images/iconoPR.jpg" />
        <link href="../css/styles.css" rel="stylesheet" type="text/css" />
    </head>
    <script>
        function operacion(accion){
            document.getElementById('action').value = accion;
            document.getElementById('formClientList').submit();
        }
        function operacion(accion, idUser){
            if(accion=='delete'){
                var r = confirm("Do you want delete a user?");
                if (r == true) {
                    document.getElementById('idUser').value = idUser;
                    document.getElementById('action').value = accion;
                    document.getElementById('formClientList').submit();
                }
            }else{
                document.getElementById('idUser').value = idUser;
                document.getElementById('action').value = accion;
                document.getElementById('formClientList').submit();
            }
        }
    </script>
    <body>
        <div id="bg1">
            <div id="content">
                <!-- header -->
                <%@include file="../template/header.jsp" %>
                <br><br>
                <!-- content -->
                <form id="formClientList" method="post" action="../ClientController">
                <input type="hidden" id="action" name="action" value="" />
                <input type="hidden" id="idUser" name="idUser" value="" />
                <center><br>
				<div style="width: 800px; alignment-adjust: central;">
                    <center><h2 class="titulo">Client Manager</h2></center>
                    <br>
                    <table class="tablaFiltro">
                        <tr>
                            <td>User Name:</td>
                            <td><input class="cajaTexto" id="txtUserName" type="text" name="txtUserName" maxlength="50"
                                       value="<%=request.getAttribute("txtUserName")==null?"":request.getAttribute("txtUserName").toString().trim()%>"/></td>
                            <td>Name:</td>
                            <td><input class="cajaTexto" id="txtName" type="text" name="txtName" value="" maxlength="50"/></td>
                            <td>Last Name:</td>
                            <td><input class="cajaTexto" id="txtLastName" type="text" name="txtLastName" value="" maxlength="50"/></td>
                        </tr>
                    </table>
                    <br>
                    <table class="tablaBotonera">
                        <tr>
                            <td><input class="boton" id="btnNew" type="button" name="btnNew" value="New Client" onclick="javascript:operacion('new');"/></td>
                            <td><input class="boton" id="btnSearch" type="button" name="btnSearch" value="Search Client" onclick="javascript:operacion('search');"/></td>
                        </tr>
                    </table>
                    <br>
                    <table class="tablaData">
                        <thead>
                            <tr>
                                <th width="50px">Id User</th>
                                <th width="150px">User Name</th>
                                <th width="200px">Name</th>
                                <th width="200px">Last Name</th>
                                <th colspan="3">Actions</th>
                            </tr>
                        </thead>
                        <%
                            Object object = request.getSession(true).getAttribute(ConstantesWeb.LIST);
                            if (object == null || ((List<User>)object).isEmpty() ){
                        %>
                        <tr>
                            <td colspan="7">No se encuentran registros</td>
                        </tr>
                        <%
                            }else{
                                for(User bean:(List<User>)object){
                        %>
                            <tr>
                                <td><%=bean.getIdUser()%></td>
                                <td><%=bean.getUserLogin()%></td>
                                <td><%=bean.getName()%></td>
                                <td><%=bean.getLastName()%></td>
                                <td style="text-align: center"><a onclick="javascript:operacion('edit', <%=bean.getIdUser()%>);"><img style="width: 18px; height: 18px;" src="../images/editar.png" alt="Edit"></a></td>
                                <td style="text-align: center"><a onclick="javascript:operacion('delete', <%=bean.getIdUser()%>);"><img style="width: 18px; height: 18px;" src="../images/eliminar.png" alt="Delete"></a></td>
                                <td style="text-align: center"><a onclick="javascript:operacion('change', <%=bean.getIdUser()%>);"><img style="width: 18px; height: 18px;" src="../images/pass.png" alt="Change Password"></a></td>
                            </tr>
                        <%
                                }
                                %>
                            <tr>
                                <th colspan="7">Max 40 register result</th>
                            </tr>
                                <%
                            }
                        %>
                    </table>
					<br><br>
                </div>
				</center>
                </form>
                <%@include file="../template/footer.jsp" %>
            </div>
        </div>
    </body>
</html>
<%
}
%>