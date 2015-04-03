<%@page import="pe.com.peruretouch.web.util.UtilWeb"%>
<%@page import="java.util.List"%>
<%@page import="pe.com.peruretouch.business.base.OperacionEnum"%>
<%@page import="pe.com.peruretouch.entity.User"%>
<%@page import="pe.com.peruretouch.business.UserBusiness"%>
<%@page import="pe.com.peruretouch.web.bean.PhotosBean"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    if (session.getAttribute(ConstantesWeb.USER_HOME) == null) {
        response.sendRedirect("../index.jsp");
    } else {
        String IdUser = "";
        String userName = "";
        String name = "";
        String lastName = "";
        String address = "";
        String country = "";
        String birthday = "";
        String telephone = "";
        String cellphone = "";
        String email = "";
        String websiteAddress = "";
        String titulo = "";
        if(session.getAttribute(ConstantesWeb.USER)!=null){
            User user = (User)session.getAttribute(ConstantesWeb.USER);
            titulo = (user.getIdUser()==null||user.getIdUser()==0)?"New":"Edit";
            IdUser = (user.getIdUser()==null||user.getIdUser()==0)?"":user.getIdUser().toString();
            userName = user.getUserLogin()==null?"":user.getUserLogin();
            name = user.getName()==null?"":user.getName();
            lastName = user.getLastName()==null?"":user.getLastName();
            address = user.getAddress()==null?"":user.getAddress();
            country = user.getCountry()==null?"":user.getCountry();
            birthday = user.getBirthDay()==null?"":UtilWeb.convertirDate(user.getBirthDay(), "yyyy-MM-dd");
            telephone = user.getTelephone()==null?"":user.getTelephone();
            cellphone = user.getCellphone()==null?"":user.getCellphone();
            email = user.getEmail()==null?"":user.getEmail();
            websiteAddress = user.getWebPage()==null?"":user.getWebPage();
        }
        String message = request.getParameter("message");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peru Retouch - Client List</title>
        <link rel="icon" type="image/png" href="../images/iconoPR.jpg" />
        <link href="../css/styles.css" rel="stylesheet" type="text/css" />
    </head>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="//cdn.jsdelivr.net/webshim/1.14.5/polyfiller.js"></script>
        <script>
            webshims.setOptions('forms-ext', {types: 'date'});
            webshims.polyfill('forms forms-ext');
        </script>
    <script>
        function operacion(accion){
            var opc = '1';    
            if(accion!='cancelSave'){
                var campos = ['txtUserName', 'txtName', 'txtLastName', 'txtAddress', 'txtCountry', 'txtBirthDay', 'txtPassword', 'txtEmail'];
                for(i = 0; i < campos.length ; i++) {
                    //document.getElementById(campos[i]).style = "background-color: #FFFFFF";
                }
                for(i = 0; i < campos.length ; i++) {
                    if(document.getElementById(campos[i])!=null){
                        if(document.getElementById(campos[i]).value==''){
                            //document.getElementById(campos[i]).style = "background-color: #FFFF66";
                            opc = '0';
                            alert('Complete field required');
                            return;
                        }
                    }
                }
            }
            if(opc == '1'){
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
                <input type="hidden" id="IdUser" name="IdUser" value="<%=IdUser%>" />
                <input type="hidden" id="UserName" name="UserName" value="<%=userName%>" />
                <center><br>
		<div style="width: 800px; alignment-adjust: central;">
                    <center><h2 class="titulo"><%=titulo%> Client</h2></center>
                    <br>
                    <table class="tablaFormulario">
                        <tr>
                            <td style="width:100px">ID User:</td>
                            <td style="width:120px"><input class="cajaTexto" id="txtIdUser" type="text" name="txtIdUser" value="<%=IdUser%>" maxlength="50" readonly="true"/></td>
                        </tr>
                        <tr>
                            <td>User Login:</td>
                            <td><input class="cajaTexto" id="txtUserName" type="text" name="txtUserName" value="<%=userName%>" maxlength="50"
                                       <%if(titulo.compareToIgnoreCase("Edit")==0){%>
                                       readonly="true"
                                       <% } %>
                                       />(*)</td>
                        </tr>
                        <tr>
                            <td>Name:</td>
                            <td><input class="cajaTexto" id="txtName" type="text" name="txtName" value="<%=name%>" maxlength="50"/>(*)</td>
                        </tr>
                        <tr>
                            <td>Last Name:</td>
                            <td><input class="cajaTexto" id="txtLastName" type="text" name="txtLastName" value="<%=lastName%>" maxlength="50"/>(*)</td>
                        </tr>
                        <tr>
                            <td>Address:</td>
                            <td><input class="cajaTexto" id="txtAddress" type="text" name="txtAddress" value="<%=address%>" maxlength="200" size="35"/>(*)</td>
                        </tr>
                        <tr>
                            <td>Country:</td>
                            <td><input class="cajaTexto" id="txtCountry" type="text" name="txtCountry" value="<%=country%>" maxlength="50"/>(*)</td>
                        </tr>
                        <tr>
                            <td>BirthDay:</td>
                            <td><input class="cajaTexto" id="txtBirthDay" type="date" name="txtBirthDay" value="<%=birthday%>" maxlength="50"/>(*)</td>
                        </tr>
                        <tr>
                            <td>Telephone:</td>
                            <td><input class="cajaTexto" id="txtTelephone" type="text" name="txtTelephone" value="<%=telephone%>" maxlength="50"/></td>
                        </tr>
                        <tr>
                            <td>Cellphone:</td>
                            <td><input class="cajaTexto" id="txtCellphone" type="text" name="txtCellphone" value="<%=cellphone%>" maxlength="50"/></td>
                        </tr>
                        <tr>
                            <td>EMail:</td>
                            <td><input class="cajaTexto" id="txtEmail" type="text" name="txtEmail" value="<%=email%>" maxlength="50"/>(*)</td>
                        </tr>
                        <tr>
                            <td>WebPage:</td>
                            <td><input class="cajaTexto" id="txtWebPage" type="text" name="txtWebPage" value="<%=websiteAddress%>" maxlength="200" size="40"/></td>
                        </tr>
                    </table>
                    <br>
                    <table class="tablaBotonera">
                        <tr>
                            <td><input class="boton" id="btnSave" type="button" name="btnNew" value="Save" onclick="javascript:operacion('save');"/></td>
                            <td><input class="boton" id="btnCancel" type="button" name="btnSearch" value="Cancel" onclick="javascript:operacion('cancelSave');"/></td>
                        </tr>
                    </table>
                    <br>
		    <br><br>
                </div>
		</center>
                </form>
                <%
                if(message!=null){
                %>
                <script>
                    alert('<%=message%>');
                </script>
                <%
                }
                %>
                <%@include file="../template/footer.jsp" %>
            </div>
        </div>
    </body>
</html>
<%
}
%>