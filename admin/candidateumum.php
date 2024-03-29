<?php session_start();
$electionid=$_SESSION['electionid'];

//If your session isn't valid, it returns you to the login screen for protection
if(empty($_SESSION['id'])){
 header("location:../index.php?error=alreadylogout");
}
include "../connection.php";

$query="SELECT c.*,v.*,f.name,s.*
FROM candidate as c 
JOIN voter as v 
ON c.voter_id=v.voter_id
JOIN faculty as f 
ON v.faculty=f.faculty_id
JOIN section as s 
ON c.section_id= s.section_id 
WHERE c.section_id=0 AND c.election_id = '$electionid'";


$qr=mysqli_query($db,$query);
if ($qr==false) {
    echo "Failed to get candidate information<br>";
    echo "SQL error :".mysqli_error($db);
}


include "include/header.template.php";
?>
        <div class="container-fluid">
          <div class="card shadow mb-4">
            <div class="card-header py-3" >
              <div class="d-sm-flex align-items-center justify-content-between mb-1">
                <h5 class="m-0  font-weight-bold text-primary">General Candidate</h5>
                <div class="pull-right"><a href="umum_voterlist.php"><button type="button" class="btn btn-primary">Add Candidates</button></a></div>
              </div>
           </div>
           <div class="card-body">
             <?php 
            // succes message
            if (isset($_GET['success'])) {
                if ($_GET['success'] == "deleted") {
                    echo '<div class="alert alert-danger" role="alert">Candidate has been deleted!</div>';
                }
                if ($_GET['success']=="updated") {
                    echo '<div class="alert alert-success" role="alert">Candidate has been updated!</div>';
                  
                }
            }
            elseif (isset($_GET['error'])) {
              if ($_GET['error']=="duplicate") {
                echo '<div class="alert alert-danger" role="alert">All the Candidate already added !</div>';
                
              }
              if ($_GET['error']=="not_allow") {
                echo '<div class="alert alert-danger" role="alert">Not Allow To Delete !</div>';
                
              }
            }
           ?>
              <table id="dtBasicExample" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                <thead>
                  <tr>
                    <th class="th-sm">Candidate ID
                    </th>
                    <th class="th-sm">Name
                    </th>
                    <th class="th-sm">Fakulti
                    </th>
                    <th class="th-sm">Section 
                    </th>
                    <th >Action
                    </th>

                  </tr>
                </thead>
                <tbody>
                  <?php
              while ($rekod=mysqli_fetch_array($qr)){
                $candidateid=$rekod['candidate_id'];
              ?>
                  <tr>
                    <td><?=$candidateid?></td>
                    <td><?=$rekod['voter_name']?></td>
                    <td><?=$rekod['name']?></td>
                    <td><?=$rekod['section_name']?></td>
                    <td>
                    <a href="update_candidate.php?type=1&candidate_id=<?=$candidateid?>" class="btn btn-info btn-circle btn-sm"> <i class="fas fa-edit"></i></a>
                      <a href="#" class="btn btn-danger btn-circle btn-sm" data-toggle="modal" 
                      data-target="#message<?=$candidateid?>"> <i class="fas fa-trash"></i></a>
                    </td>
                  </tr>

                  <!-- Logout Modal-->
                    <div class="modal fade" id="message<?=$candidateid?>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                      <div class="modal-dialog" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Are you sure want to delete this candidate?</h5>
                            <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">×</span>
                            </button>
                          </div>
                          <div class="modal-body"><?=$rekod['voter_name']?></div>
                          <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                            <a class="btn btn-danger" href="deletecandidate.php?deletecandidate_id=<?=$candidateid?>">Delete</a>
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
                    <th >Candidate ID
                    </th>
                    <th >Name
                    </th>
                    <th >Fakulti
                    </th>
                    <th >Section 
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

