$(document).ready(function()
{
    docenteForm = $("#create-docente-form");
    rowContainerDocentes = $("#docentes-table-body");

    fetchDocentes();

    $(docenteForm).validate({
        rules: {
            primer_nombre:
            {
                required: true,
                minlength: 2,
                maxlength:50
            },
            apellido_paterno:
            {
                required: true,
                minlength: 2
            },
            apellido_materno:
            {
                required: true,
                minlength: 2
            },
            clave:
            {
                required: true,
            },
            contrato:
            {
                required: true,
            },
            calle:
            {
                required: true,
            },
            numero:
            {
                required: true,
            },
            colonia:
            {
                required: true,
            },
        },
        messages:{
            primer_nombre:
            {
                required: "Campo requerido",
                minlength: 2,
                maxlength:50
            },
            apellido_paterno:
            {
                required: "Campo requerido",
                minlength:"Mínimo 2 caracteres"
            },
            apellido_materno:
            {
                required: "Campo requerido",
                minlength:"Mínimo 2 caracteres"
            },
            clave:
            {
                required: "Campo requerido",
            },
            contrato:
            {
                required: "Campo requerido",
            },
            creditos:
            {
                required: "Campo requerido",
            },
            calle:
            {
                required: "Campo requerido",
            },
            numero:
            {
                required: "Campo requerido",
            },
            colonia:
            {
                required: "Campo requerido",
            }
        }
    });

    $(docenteForm).submit(function(e)
    {
        e.preventDefault();
        insertDocente(docenteForm);
    });

});

function fetchDocentes()
{
    //OBTIENE DOCENTES
    $.ajax({
        url: "./controllers/DocenteController.php",
        type: "POST",
        data: {functionname: "FetchDocentes"},

        success: function(msg, status, jqXHR)
        {
            const json = JSON.parse(msg);
            if(json.success)
            {
                let i = 0
                json.data.forEach(docente => {
                    $(rowContainerDocentes).append(createRowDocente(i, docente));       
                    i++;
                });
            }
        },
        error: function(xhr, status, error)
        {
            var err = eval("(" + xhr.responseText + ")");
            console.log(err);
        }
    });
}

function insertDocente(f_form)
{
    if(docenteForm.valid())
    {
        //INSERTA DOCENTE
        $.ajax({
            url: "./controllers/DocenteController.php",
            type: "POST",
            data: f_form.serializeArray(),
    
            success: function(msg, status, jqXHR)
            {
                console.log(msg);
                const json = JSON.parse(msg);
                if(json.success)
                {
                    location.reload();
                }
            },
            error: function(xhr, status, error)
            {
                var err = eval("(" + xhr.responseText + ")");
                console.log(err);
            }
        });
    }
}

function createRowDocente(f_index, f_docente)
{
    const row = document.createElement("tr");

    const indexElement = document.createElement("th");
    $(indexElement).attr("scope", "row");
    $(indexElement).html(`#${f_index+1}`);
    $(row).append(indexElement);

    const nombreElement = document.createElement("td");
    if(f_docente.segundo_nombre)
        $(nombreElement).html(`${f_docente.primer_nombre} ${f_docente.segundo_nombre} ${f_docente.apellido_paterno} ${f_docente.apellido_materno}`);
    else
        $(nombreElement).html(`${f_docente.primer_nombre} ${f_docente.apellido_paterno} ${f_docente.apellido_materno}`);
    $(row).append(nombreElement);

    const claveElement = document.createElement("td");
    $(claveElement).html(f_docente.clave);
    $(row).append(claveElement);

    const contratoElement = document.createElement("td");
    $(contratoElement).html(f_docente.contrato);
    $(row).append(contratoElement);
    
    const direccionElement = document.createElement("td");
    $(direccionElement).html(`${f_docente.calle} ${f_docente.numero} ${f_docente.colonia}`);
    $(row).append(direccionElement);
    
    const telefonosElement = document.createElement("td");
    $(telefonosElement).html(`${f_docente.telfono}`);
    $(row).append(telefonosElement);

    const optionsElement = document.createElement("td");
    const deleteBtn = document.createElement("span");
    $(deleteBtn).html(getDeleteIcon());
    var claveDocente = f_docente.clave;
    $(deleteBtn).click({claveDocente}, DeleteDocente);
    $(optionsElement).html(deleteBtn);
    $(row).append(optionsElement);

    return row;
}

function DeleteDocente(event)
{
    if (confirm(`Seguro que desea borrar al docente con clave: ${event.data.claveDocente}?`)) 
    {
        // BORRA DOCENTE
        $.ajax({
            url: "./controllers/DocenteController.php",
            type: "POST",
            data: {functionname: "DeleteDocente", clave: event.data.claveDocente},
    
            success: function(msg, status, jqXHR)
            {
                const json = JSON.parse(msg);
                if(json.success)
                {
                    console.log(json);
                    location.reload();
                }
            },
            error: function(xhr, status, error)
            {
                var err = eval("(" + xhr.responseText + ")");
                console.log(err);
            }
        });
    
    } 
}

function getDeleteIcon()
{
    return `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-trash-x-filled" width="32" height="32" viewBox="0 0 24 24" stroke-width="1.5" stroke="#000000" fill="none" stroke-linecap="round" stroke-linejoin="round">
    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
    <path d="M20 6a1 1 0 0 1 .117 1.993l-.117 .007h-.081l-.919 11a3 3 0 0 1 -2.824 2.995l-.176 .005h-8c-1.598 0 -2.904 -1.249 -2.992 -2.75l-.005 -.167l-.923 -11.083h-.08a1 1 0 0 1 -.117 -1.993l.117 -.007h16zm-9.489 5.14a1 1 0 0 0 -1.218 1.567l1.292 1.293l-1.292 1.293l-.083 .094a1 1 0 0 0 1.497 1.32l1.293 -1.292l1.293 1.292l.094 .083a1 1 0 0 0 1.32 -1.497l-1.292 -1.293l1.292 -1.293l.083 -.094a1 1 0 0 0 -1.497 -1.32l-1.293 1.292l-1.293 -1.292l-.094 -.083z" stroke-width="0" fill="currentColor" />
    <path d="M14 2a2 2 0 0 1 2 2a1 1 0 0 1 -1.993 .117l-.007 -.117h-4l-.007 .117a1 1 0 0 1 -1.993 -.117a2 2 0 0 1 1.85 -1.995l.15 -.005h4z" stroke-width="0" fill="currentColor" />
  </svg>`;
}