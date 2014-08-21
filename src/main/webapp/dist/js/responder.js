$(function() {
    jQuery.extend(jQuery.validator.messages, {
        required: "Este campo es requerido."
    });
    $("#form_encuesta").validate({
        debug: true,
        submitHandler: function() {
            this.timer = setTimeout(function() {
                $.ajax({
                    url: 'Encuestas?accion=guardarEncuesta',
                    data: $("#form_encuesta").serialize(),
                    type: 'post',
                    success: function() {
                        console.log("huepaje");
                        $("#myModalGracias").modal();
                        $('#myModalGracias').on('hide.bs.modal', function() {
                            location = "/planeacion/";
                        });
                    }

                });
            }, 400);
        }
    });
    $(".form-group .radio input[type=radio]").change(function() {
        if ($(this).prop("value") === "otro") {
            $(this).parents("div.radio").find("input[type=text]").prop('disabled', false);
            $(this).parents("div.radio").find("input[type=text]").focus();
        } else {
            $(this).parents(".form-group").find("input[type=text]");
            $(this).parents(".form-group").find("input[type=text]").prop('disabled', "disabled");
        }
    });
    $('.tipo1').change(function() {
        var selector = $(this).parents("div.checkbox").children("select");
        var input = $(this).parents("div.checkbox").children("input[type=text]");
        if ($(this).is(":checked")) {
            $(selector).prop('disabled', false);
            $(input).prop('disabled', false);
        } else {
            $(selector).prop('disabled', 'disabled');
            $(input).prop('disabled', 'disabled');
        }
    });
    $('.tipo2').change(function() {
        var input = $(this).parents("div.checkbox").children("input[type=text]");
        if ($(this).is(":checked")) {
            $(input).prop('disabled', false);
        } else {
            $(input).prop('disabled', 'disabled');
        }
    });
    $(".condicionador2").change(function() {
        var preguntaCondicionada = $(this).attr("datacondicion2").replace(/\s+/g, '');
        if ($(this).is(":checked")) {
//var vectorPregunta = preguntaCondicionada.split(",");
//for (var i = 0; i < vectorPregunta.length; i++) {
            $("#" + preguntaCondicionada).addClass("hide");
            //}
        } else {
            $("#" + preguntaCondicionada).removeClass("hide");
        }
    });
    $(".condicionador input[type=radio]").change(function() {
        if ($(this).is(":checked")) {
            if ($(this).hasClass("datacondicion")) {
                var preguntaCondicionada = $(this).attr("datacondicion").replace(/\s+/g, '');
                var vectorPregunta = preguntaCondicionada.split(",");
                for (var i = 0; i < vectorPregunta.length; i++) {
                    $("#" + vectorPregunta[i]).removeClass("hide");
                }

            } else {
                var preguntaCondicionada = $(this).parents(".condicionador").find(".datacondicion").attr("datacondicion").replace(/\s+/g, '');
                var vectorPregunta = preguntaCondicionada.split(",");
                for (var i = 0; i < vectorPregunta.length; i++) {
                    $("#" + vectorPregunta[i]).addClass("hide");
                }

            }
        }

    });
    $(".condicionador3 input[type=radio]").change(function() {
        if ($(this).is(":checked")) {
            if ($(this).hasClass("datacondicion")) {
                var preguntaCondicionada = $(this).attr("datacondicion").replace(/\s+/g, '');
                var vectorPregunta = preguntaCondicionada.split(",");
                for (var i = 0; i < vectorPregunta.length; i++) {
                    $("#" + vectorPregunta[i]).addClass("hide");
                }

            } else {
                var preguntaCondicionada = $(this).parents(".condicionador3").find(".datacondicion").attr("datacondicion").replace(/\s+/g, '');
                var vectorPregunta = preguntaCondicionada.split(",");
                for (var i = 0; i < vectorPregunta.length; i++) {
                    $("#" + vectorPregunta[i]).removeClass("hide");
                }

            }
        }

    });
});


