<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap core CSS -->
        <link href="<%=request.getContextPath()%>/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Documentation extras -->
        <link href="<%=request.getContextPath()%>/assets/css/docs.min.css" rel="stylesheet">
        <!--[if lt IE 9]><script src="assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

        <!-- Favicons -->
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="shortcut icon" href="assets/ico/favicon.ico">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script src="<%=request.getContextPath()%>/dist/js/bootstrap.min.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/jquery.validate.js"></script>
        <script src="<%=request.getContextPath()%>/assets/js/main.js"></script>
        <script type="text/javascript">
            $(function() {
                $("#formCrearEncuesta").validate({
                    submitHandler: function() {
                        $.ajax({
                            type: 'POST',
                            url: "Encuestas?accion=crearEncuesta2",
                            data: $("#formCrearEncuesta").serialize(),
                            success: function() {
                                location = "encuestas/listar.jsp";
                            } //fin success
                        }); //fin $.ajax
                    }
                });
            });
        </script>
    </head>
    <body>
        <form method="post" class="form-horizontal" id="formCrearEncuesta">
            <fieldset>
                <legend>Crear Encuesta</legend>
                <div class="control-group">
                    <label class="control-label" for="nombre">Nombre</label>
                    <div class="controls">
                        <input type="text" value="" class="input-xlarge required" id="nombre" name="nombre">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="objetivo">Objetivo</label>
                    <div class="controls">
                        <textarea class="input-xxlarge required"  id="objetivo" name="objetivo" rows="3"></textarea>
                    </div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Crear Encuesta</button>
                    <button type="reset" class="btn">Cancelar</button>
                </div>
            </fieldset>
        </form>
    </body>
</html>
