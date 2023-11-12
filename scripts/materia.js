$(document).ready(function(){
    fetchMaterias();
    formMateria = $("#create-materia-form");  
    rowContainerMaterias = $("#materias-table-body");

    $(formMateria).validate({
        rules: {
            nombre:
            {
                required: true,
                minlength: 2,
                maxlength:50
            },
            clave:
            {
                required: true,
                minlength: 2,
                maxlength:10
            },
            creditos:
            {
                required: true,
            }
        },
        messages:{
            nombre:
            {
                required: "Campo 'nombre del campus' es requisito",
                minlength: "Mínimo 2 caracteres",
                maxlength: "Máximo 50 caracteres"
            },
            clave:
            {
                required: "Campo requerido",
                minlength: "Mínimo 2 caracteres",
                maxlength: "Máximo 10 caracteres"
            },
            creditos:
            {
                required: "Campo requerido"
            }
        }
    });

    $(formMateria).submit(function(e)
    {
        e.preventDefault();
        insertMateria(formMateria);
    });
});

function fetchMaterias()
{
    //INSERTA MATERIA
    $.ajax({
        url: "./controllers/MateriaController.php",
        type: "POST",
        data: {functionname: "FetchMaterias"},

        success: function(msg, status, jqXHR)
        {
            const json = JSON.parse(msg);
            if(json.success)
            {
                let i = 0
                json.data.forEach(materia => {
                    $(rowContainerMaterias).append(createRowMateria(i, materia));       
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

function insertMateria(f_form)
{
    if(formMateria.valid())
    {
        //INSERTA MATERIA
        $.ajax({
            url: "./controllers/MateriaController.php",
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

function createRowMateria(f_index, f_materia)
{
    const row = document.createElement("tr");

    const indexElement = document.createElement("th");
    $(indexElement).attr("scope", "row");
    $(indexElement).html(`#${f_index+1}`);
    $(row).append(indexElement);

    const claveElement = document.createElement("td");
    $(claveElement).html(f_materia.clave);
    $(row).append(claveElement);

    const nombreElement = document.createElement("td");
    $(nombreElement).html(f_materia.nombre);
    $(row).append(nombreElement);

    const creditosElement = document.createElement("td");
    $(creditosElement).html(f_materia.creditos);
    $(row).append(creditosElement);

    const optionsElement = document.createElement("td");
    const deleteBtn = document.createElement("span");
    $(deleteBtn).html(getDeleteIcon());
    var claveMateria = f_materia.clave;
    $(deleteBtn).click({claveMateria}, DeleteMateria);
    $(optionsElement).html(deleteBtn);
    $(row).append(optionsElement);

    return row;
}

function getDeleteIcon()
{
    return `<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-trash-x-filled" width="32" height="32" viewBox="0 0 24 24" stroke-width="1.5" stroke="#000000" fill="none" stroke-linecap="round" stroke-linejoin="round">
    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
    <path d="M20 6a1 1 0 0 1 .117 1.993l-.117 .007h-.081l-.919 11a3 3 0 0 1 -2.824 2.995l-.176 .005h-8c-1.598 0 -2.904 -1.249 -2.992 -2.75l-.005 -.167l-.923 -11.083h-.08a1 1 0 0 1 -.117 -1.993l.117 -.007h16zm-9.489 5.14a1 1 0 0 0 -1.218 1.567l1.292 1.293l-1.292 1.293l-.083 .094a1 1 0 0 0 1.497 1.32l1.293 -1.292l1.293 1.292l.094 .083a1 1 0 0 0 1.32 -1.497l-1.292 -1.293l1.292 -1.293l.083 -.094a1 1 0 0 0 -1.497 -1.32l-1.293 1.292l-1.293 -1.292l-.094 -.083z" stroke-width="0" fill="currentColor" />
    <path d="M14 2a2 2 0 0 1 2 2a1 1 0 0 1 -1.993 .117l-.007 -.117h-4l-.007 .117a1 1 0 0 1 -1.993 -.117a2 2 0 0 1 1.85 -1.995l.15 -.005h4z" stroke-width="0" fill="currentColor" />
  </svg>`;
}

function DeleteMateria(event)
{
    if (confirm(`Seguro que desea borrar la materia con clave: ${event.data.claveMateria}?`)) 
    {
        // //INSERTA MATERIA
        $.ajax({
            url: "./controllers/MateriaController.php",
            type: "POST",
            data: {functionname: "DeleteMateria", clave: event.data.claveMateria},
    
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