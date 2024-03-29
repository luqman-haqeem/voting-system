<?php session_start();
$electionid=$_SESSION['electionid'];

//If your session isn't valid, it returns you to the login screen for protection
if(empty($_SESSION['id'])){
 header("location:../index.php");
}

include "../connection.php";

$query="SELECT v.*,f.*
        FROM voter as v
        JOIN faculty as f 
        ON v.faculty=f.faculty_id
        WHERE voter_id NOT IN 
        (SELECT voter_id FROM candidate WHERE election_id ='$electionid')";

$qr=mysqli_query($db,$query);
if ($qr==false) {
    echo "Failed to get voterlist in fakulti<br>";
    echo "SQL error :".mysqli_error($db);
}

include "include/header.template.php";
?>
<div class="container-fluid">
  <div class="card shadow mb-4">
    <div class="card-header py-3" >
      <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h5 class="m-0  font-weight-bold text-primary">Please select candidate</h5>
      </div>
    </div>
    <div class="card-body">
      <table id="dtBasicExample" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
        <p id="facultycandidate_table"></p>
        <?php  if (isset($_GET['error'])) {
              if ($_GET['error'] == "alreadycandidate") {
                echo '<div class="alert alert-danger" role="alert">Voter already candidate!</div> ';
              }
              elseif ($_GET['error'] == "alreadyfacultycandidate") {
                echo '<div class="alert alert-danger" role="alert">Voter already faculty candidate!</div> ';
              }
            }
         ?>
        <thead>
          <tr>
            <th class="th-sm">Voter ID
            </th>
            <th class="th-sm">Name
            </th>
            <th class="th-sm">Matric No
            </th>
            <th class="th-sm">Faculty
            </th>
            <th >Action
            </th>

          </tr>
        </thead>
        <tbody>
          <?php
      while ($rekod=mysqli_fetch_array($qr)){
        $voterid=$rekod['voter_id'];
      ?>
          <tr>
       <td><?=$voterid?></td>
       <td><?=$rekod['voter_name']?></td>
       <td><?=$rekod['matric_no']?></td>
       <td><?=$rekod['name']?></td>
            <td>
              <a href="#" class="btn btn-success btn-circle btn-sm" data-toggle="modal" data-target="#message<?=$voterid?>"> <i class="fas fa-plus"></i></a>
            </td>
          </tr>
         <!-- add fakulti candidate Modal-->
        <div class="modal fade bd-example-modal-lg" id="message<?=$voterid?>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add this voter as Faculty candidate? </h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row">
                          <div class="col-md-2"><b>Matric no</b></div>
                          <div class="col-md-6"><b>Voter Name</b></div>
                          <div class="col-md-2"><b>Faculty</b></div>
                          <!-- <div class="col-md-2"><b>Section</b></div> -->
                        </div>
                        <div class="row">
                          <div class="col-md-2"><?=$rekod['matric_no']?></div>
                          <div class="col-md-6"><?=$rekod['voter_name']?></div>
                          <div class="col-md-2"><?=$rekod['name']?></div>
                          <!-- <div class="col-md-2">Faculty</div> -->
                        </div>
                        <br>
                        <div class="row">
                          <div class="col-md-6"><b>Candidate Motto</b></div>
                        </div>
                        <div class="row">
                          <form action="fakulti_addcandidate.php" method="GET">
                          <div class="col-md-6">
                            <input type="text" name="candidate_motto" id="candidate_motto" class="form-control">
                            <input type="hidden" name="voterid" id="voterid" value="<?=$voterid?>">
                          </div>
                          
                        </div>
                    </div>
                    </div>
                <div class="modal-footer">
                  <button class="btn btn-danger" type="button" data-dismiss="modal">No</button>
                  <input type="submit" value="Yes" class="btn btn-success">
                <!-- <a class="btn btn-success" href="fakulti_addcandidate.php?voterid=<?=$voterid?>">Yes</a> -->

                </form>
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

