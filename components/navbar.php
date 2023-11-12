<div class="navbar">
    <div class="navbar-categories">
        <a href="./">INICIO</a>
        <a href="./materias.php">MATERIAS</a>
        <a href="./docentes.php">DOCENTES</a>
        <a href="./alumnos.php">ALUMNOS</a>
    </div>
    <svg xmlns="http://www.w3.org/2000/svg" width="3rem" height="3rem" viewBox="-0.5 0 25 25" fill="none">
        <path d="M2 12.32H22" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M2 18.32H22" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M2 6.32001H22" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
    </svg>
</div>

<style>
    .navbar
    {   
        position:absolute;
        display:flex;
        flex-direction:row;
        width: 100%;
        height: 7rem;
        background: rgba(163, 217, 171, 1);
        margin: 0 0 0 0;
        box-shadow: 5px 5px 15px rgba(125,125,125,0.5);
    }

    div.navbar-categories
    {
        font-family: 'Young Serif', serif;
        display:flex;
        flex-direction:row;
        justify-content:space-between;
        align-content:center;
        width:100%;
        font-size: 1.5rem;
        margin:auto;
    }

    .navbar-categories a
    {
        margin:auto;
        text-align:middle;
        text-decoration: none;
        color: rgb(255,255,255);
    }

    .navbar svg
    {
        margin-right:1rem;
        display:none;
    }

    /* MOBILE */
    @media (max-width: 480px) 
    {
    }

    /* TABLETS */
    @media (max-width: 768px) 
    {
        .navbar
        {
            justify-content:space-between;
        }

        .navbar svg
        {
            margin-right:1rem;
            display:block;
        }

        div.navbar-categories
        {
            display:none;
        }
    }
    /* SMALL SCREENS, LAPTOPS */
    @media (max-width: 1024px) 
    {
        
    }
    /* DESKTOPS, LARGE SCREENS */
    @media (max-width: 1200px) 
    {
        
    }
    /* EXTRA LARGE SCREENS, TV */
    @media (min-width: 1200px) 
    {
        
    }
</style>