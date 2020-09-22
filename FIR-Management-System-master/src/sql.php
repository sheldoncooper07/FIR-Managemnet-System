<?php 
session_start(); 

if(isset($_POST['query'])){
   if(preg_match('/[[:alnum:]]/',$_POST['sql'])){
       $_SESSION['query'] = $_POST['sql'];
   }else{
       $_SESSION['query'] = 'show tables';
   }
redirect('results.php');
}else if(isset($_POST['logout'])){
    session_destroy();
    header('Location:index.php');
} else if(isset($_POST['table'])) {
    // $_SESSION['query'] = 'select * from '.$_POST['name'];
    $_SESSION['name'] = $_POST['name'];
    // echo $_POST['name'];
    redirect('table.php');
}
function redirect($url)
{
    if (!headers_sent())
    {    
        header('Location: '.$url);
        exit;
        }
    else
        {  
        echo '<script type="text/javascript">';
        echo 'window.location.href="'.$url.'";';
        echo '</script>';
        echo '<noscript>';
        echo '<meta http-equiv="refresh" content="0;url='.$url.'" />';
        echo '</noscript>'; exit;
    }
}
?>

<!DOCTYPE html>
<html>
    <head>
        
        <link href="style.css" rel="stylesheet">
        <script type='text/javascript' src='https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js'></script>
        <script>
            $("#logout").click(function() {
                  //destroy session and redirect
            });
            function showHide(){
                $('#sql').show();
                $('#results').hide();
            }
            window.onload =showHide;
        </script>
    </head>
    <body>
        <header style='text-align:center;'>
            <h1>FIR Management System</h1>
        </header>
        <div id='middle' style='width: auto;height: 1000px; '>
        <div id='center' style='width: 1000px;margin-left: auto;margin-right: auto;'>
        <hr />
            <div id='l-middle' style='float: right; text-align:center;'>
                <b>Welcome back</b><br />
                <?php echo $_SESSION['username']; ?><br />
                <form method="post" action="sql.php">
                    <input type='submit' value='Logout' id='logout' name='logout'/>
                </form>
            </div><!--END OF L-MIDDLE-->

            <div style='float: right;'>
                <h2> Check individual tables</h2> 
                <?php
                    include('dbengine.php');
                    $database = Database_Factory::create(1);
                    $database->connect('localhost','root','Piyush@123','firdata');
                    $res = $database->run_query('show tables');

                    if(is_string($res)){
                        $results_string .= $res;
                    }else{
                        $results = $res;
                        $field_count = $results->field_count;
                        $fields = $results->fetch_fields();

                        $results_string = '<table border=1 class="display">';
                        $results_string .= '<tr style="color:green;"> <td>Table Name</td> <td>Schema</td> </tr>';
                        while($row = $results->fetch_row()){
                            for($i = 0; $i < $field_count; $i++){
                                $link = '<form method="post" action="sql.php">';
                                $link .= '<textarea name="name" style="display:none;" id="name">';
                                $link .= $row[$i].'</textarea>';
                                $link .= "<input type='submit' value='".$row[$i]."' id='table' name='table'/>";
                                $link .= '</form>';
                                $results_string .= '<tr> <td>'.$link.'</td><td> | ';
                                $res1 = $database->run_query('select * from '.$row[$i]);
                                $fields1 = $res1->fetch_fields();
                                foreach($fields1 as $fa){
                                    $results_string .= $fa->name.' | ';
                                }
                                $results_string .= '</td></tr>';
                            }
                        }
                        $results_string .= '</table>';
                    }

                    echo $results_string;
                ?>

            </div>

            <div style='float: left;'>
                <div id='sql'>
                    <h2>Enter Query</h2>
                    <p> Please enter a valid query or update statement. You may also just press "Submit Query" to show get all the tables from the database.</p>
                    <form method="post" action="sql.php">
                        <textarea rows='10' cols='70' id='sql' name='sql'></textarea>
                        <table>
                            <tr>
                                <td><input type='submit' value='Submit Query' id='query' name='query'/></td>
                                <td><input type='reset' value='Reset Window' /></td>
                            </tr>
                        </table>
                    </form>
                </div>
                <div id='results'></div>
            </div> <!--END OF R-MIDDLE-->
            <div id='footer' style='clear:both;'>
                <hr />
            </div><!--END OF FOOTER-->
            </div> <!--END OF CENTER-->
        </div> <!--END OF MIDDLE-->


    </body>
</html>
