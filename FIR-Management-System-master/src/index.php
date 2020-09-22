<?php
session_start();
?>
<!DOCTYPE html>
<html>
    <head>
        <link href="style.css" rel="stylesheet">
        <title>
            FIR Management
        </title>
    </head>
    <body>
        <header style="text-align:center;">
            <h1>FIR Management System</h1>
        </header>
        <div id="middle" style="width: auto;height: 1000px; ">
        <div id="center" style="width: 1000px;margin-left: auto;margin-right: auto;">
        <hr />
            <div id="l-middle" style="float: left;">
                <form method="post" action="validator.php">
                    <table>
                        <tr>
                            <td><label for="username">Username: </label></td>
                            <td><input type="textbox" id="username" name="username" style="width: 150px;"/></td>
                        </tr>
                        <tr>
                            <td><label for="password">Password: </label></td>
                            <td><input type="password" id="password" name="password" style="width: 150px;"/></td>
                        </tr>
                    </table>
                    <input type="submit" />
                </form>
            </div><!--END OF L-MIDDLE-->
            <div id="r-middle" style="float: right;">
                <h2>Welcome to the Database Client</h2>
                <p>This will allow you to run SQL queries and update statements on the FIR Database.</p>
            </div> <!--END OF R-MIDDLE-->
            <div id='footer' style='clear:both;'>
                <hr />
            </div><!--END OF FOOTER-->
            </div> <!--END OF CENTER-->
        </div> <!--END OF MIDDLE-->


    </body>
</html>
