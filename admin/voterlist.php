<?php session_start();

$electionid=$_SESSION['electionid'];
//If your session isn't valid, it returns you to the login screen for protection
if(empty($_SESSION['id'])){
 header("location:../index.php?error=alreadylogout");
}

include "../connection.php";
// sort data based on faculty
$status="active";
if (isset($_GET['data'])) {
    $faculty_id=$_GET['data'];
    switch ($faculty_id) {
      case '1':
      $fstm_status=$status;
        break;
      case '2':
      $fsu_status=$status;
        break;
      case '3':
      $fpm_status=$status;
        break;
      case '4':
      $fppi_status=$status;
        break;
      case '5':
      $fp_status=$status;
        break;
      default:
      $all_status=$status;
        break;
    }
        $query="SELECT v.*, f.*
            FROM voter as v
            JOIN faculty as f
            ON v.faculty = f.faculty_id 
            WHERE v.faculty='$faculty_id' ";
  }
  else{
     $all_status=$status;
     $query="SELECT v.*, f.*
     FROM voter as v
     JOIN faculty as f
     ON v.faculty = f.faculty_id";
  }


$qr=mysqli_query($db,$query);
if ($qr==false) {
    echo "Query cannot been executed<br>";
    echo "SQL error :".mysqli_error($db);
}

//Check the record effected, if no records,
//display a message
if(mysqli_num_rows($qr)==0){
// echo ("No record fetched...<br>");
}//end no record


include "include/header.template.php";
?>

<div class="container-fluid">

     <div class="card shadow mb-4">

    <div class="card-header py-3" >
      <div class="d-sm-flex align-items-center justify-content-between mb-1">
       <h5 class="m-0  font-weight-bold text-primary">Voter</h5>
       <div class="pull-right"><a href="addvoter.php"><button type="button" class="btn btn-primary">Add Voter</button></a> </div>
      </div>
    </div>


    <div class="card-body">

      <ul class="nav nav-pills">
      <li class="nav-item">
        <a class="nav-link <?=$all_status?> " href="voterlist.php">All</a>
      </li>
      <li class="nav-item">
        <a class="nav-link <?=$fstm_status?>" href="voterlist.php?data=1">FSTM</a>
      </li>
      <li class="nav-item">
        <a class="nav-link <?=$fpm_status?> " href="voterlist.php?data=3">FPM</a>
      </li>
      <li class="nav-item">
        <a class="nav-link <?=$fppi_status?> " href="voterlist.php?data=4">FPPI</a>
      </li>
      <li class="nav-item">
        <a class="nav-link <?=$fsu_status?> " href="voterlist.php?data=2">FSU</a>
      </li>
      <li class="nav-item">
        <a class="nav-link <?=$fp_status?> " href="voterlist.php?data=5">FP</a>
      </li>
    </ul>
    <hr>
       <?php 
            // succes message
            if (isset($_GET['success'])) {
                if ($_GET['success'] == "inserted") {
                   $voterduplicate=$_GET['duplicate'];
                   $voteradded=$_GET['added'];
                   $totalvoter=$_GET['totalvoter'];
                    echo '<div class="alert alert-success" role="alert">Succesfully add '.$voteradded.' voter! ( there are: '. $voterduplicate.' duplicate voter. total = '.$totalvoter.')</div>';
                }
                elseif ($_GET['success'] == "deleted") {
                    echo '<div class="alert alert-danger" role="alert">Voter has been deleted!</div>';
                }
                elseif ($_GET['success']=="updated") {
                    echo '<div class="alert alert-success" role="alert">Data has been updated!</div>';
                  
                }
            }
            elseif (isset($_GET['error'])) {
              if ($_GET['error']=="duplicate") {
                echo '<div class="alert alert-danger" role="alert">All the voter already added !</div>';
                
              }
              if ($_GET['error']=="not_allow") {
                echo '<div class="alert alert-danger" role="alert">Not Allow To Delete !</div>';
                
              }
            }
           ?>
      <table id="dtBasicExample" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
        <thead>
          <tr>
            <th class="th-sm">Voter ID</th>

            <th class="th-sm">Name</th>
            <th class="th-sm">Matric No</th>
            <th class="th-sm">Faculty</th>
            <th >Action</th>

          </tr>
        </thead>
        <tbody>
          <?php
      while ($rekod=mysqli_fetch_array($qr)){//redo to other records
        $voterid=$rekod['voter_id'];
      ?>
          <tr>
       <td><?=$voterid?></td>
       <td><?=$rekod['voter_name']?></td>
       <td><?=$rekod['matric_no']?></td>
       <td><?=$rekod['name']?></td>
            <td>
              
              <a href="updatevoter.php?voter_id=<?=$voterid?>" class="btn btn-info btn-circle btn-sm"> <i class="fas fa-edit"></i></a>
              <a href="#" class="btn btn-danger btn-circle btn-sm" data-toggle="modal" data-target="#message<?=$voterid?>"> <i class="fas fa-trash"></i></a>
            </td>
          </tr>

           <!-- Logout Modal-->
            <div class="modal fade" id="message<?=$voterid?>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Are you sure want to delete this   voter?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">×</span>
                    </button>
                  </div>
                  <div class="modal-body"><?=$rekod['voter_name']?></div>
                  <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-danger" href="deletevoter.php?delete_voter_id=<?php echo $voterid?>">Delete</a>
                  </div>
                </div>
              </div>
            </div>
        <?php


        }//end of records
      ?>
        </tbody>
        <tfoot>
          <tr>
            <th>Voter ID
            </th>
            <th>Name
            </th>
            <th>Matric No
            </th>
            <th>Faculty
            </th>
            <th >Action
            </th>
          </tr>
        </tfoot>
      </table>
    </div>
  </div>
</div>
<?php
include "include/footer.template.php";
?>	
<script>
	$(document).ready(function () {
$('#dtBasicExample').DataTable();
$('.dataTables_length').addClass('bs-select');
});
</script>