<?php session_start();
include '../connection.php';
// get current local time
date_default_timezone_set('Asia/Kuala_Lumpur');
$time=date('Y-m-d H:i:s');
// get pilihan umum
$pilihanumum=$_SESSION['umum'];
// get pilihan fakulti 
$pilihanfakulti=$_SESSION['fakulti'];
// check if there is no candidate selected
if (empty($pilihanumum)) {
header('Location: votingpageumum.php?selection_empty');
}
elseif (empty($pilihanfakulti)) {
header('Location: votingpagefakulti.php?selection_empty');
}

// get voter id, voter faculty_id & election id from session
$voterid=$_SESSION['id'];
$voterfaculty=$_SESSION['faculty'];
$electionid=$_SESSION['electionid'];
// check if voter already vote
$alreadyvote_inDB=mysqli_query($db,"SELECT * FROM alreadyvote WHERE voter_id= '$voterid' AND election_id= '$electionid' ");
if(mysqli_num_rows($alreadyvote_inDB)>0){
  echo ("Your already vote<br>");
  header('Location: error_votingpage.php?error=alreadyvote');
}
// change time format to match with current times
$endtime=date("Y-m-d H:i:s", strtotime($_SESSION['electionendtime']));
  // check if election reach end time if true set election status to end
  if($time>="$endtime"){
    $status="End";
    $election_detail['status']=$status;
    $qr=mysqli_query($db,"UPDATE election set status='$status' WHERE  election_id=$electionid");
    if ($qr==false) {
      echo "Failed to update election status<br>";
      echo "SQL error :".mysqli_error($db);
    }
    echo "election has ended";
    header("Location: error_votingpage.php?error=electionended");
  }
  else{
   header("Refresh:30");
  }

include 'include/header_votingpage.php' 
?>
<html>
<body>
  <div class="container-fluid" align="center" >
    <!-- Outer Row -->
    <div class="row justify-content-center">

      <div class="col-xl-9 col-lg-12 col-md-9">
        <!-- card element -->
        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-header py-3" >
            <h5 class="m-0  font-weight-bold text-primary">Confirmation</h5>
          </div>
          <div class="card-body p-0">
            <div class="p-5">
              <div class="row">
                <div class="col">
                  <h3>General Candidate</h3>
                    <div class="table-reponsive">
                      <table class="table table-bordered table-fixed">
                        <tr>
                          <th class="th-sm" >Candidate ID</th>
                          <th class="th-sm" >Candidate Name</th>
						  <th class="th-sm" >Candidate Motto</th>
                        </tr>
                        <?php
                          // get umum candidate information from DB
                          foreach ($pilihanumum as $key => $candidate_id) {
                            $query="SELECT c.*,v.*
                                    FROM candidate as c 
                                    JOIN voter as v
                                    ON c.voter_id=v.voter_id 
                                    WHERE c.candidate_id='$candidate_id'";
                            $qr=mysqli_query($db,$query);
                            if ($qr==false) {
                                echo "Query cannot been executed<br>";
                                echo "SQL error :".mysqli_error($db);
                            }
                            $record=mysqli_fetch_array($qr);
                            $name=$record['voter_name'];
							$motto=$record['candidate_motto'];
                        ?> 
                        <tr>
                          <td><?=$candidate_id?></td>
                          <td><?=$name?></td>
						  <td><?=$motto?></td>
                        </tr>
                        <!-- close loop -->
                        <?php } ?>
                      </table>
                    </div>
                </div>
                      <div class="col">
                        <h3>Faculty Candidate</h3>
                        <table class="table table-bordered table-fixed ">
                          <tr>
                            <th class="th-sm" >Candidate ID</th>
                            <th class="th-sm" >Candidate Name</th>
							<th class="th-sm" >Candidate Motto</th>
                          </tr>
                          <?php
                            // get fakulti candidate information from DB
                            foreach ($pilihanfakulti as $key => $candidate_id) {
                              $query="SELECT c.*,v.*,f.*
                                      FROM candidate as c 
                                      JOIN voter as v
                                      ON c.voter_id=v.voter_id 
                                      JOIN faculty as f
                                      ON v.faculty=f.faculty_id
                                      WHERE c.candidate_id='$candidate_id'";
                              $qr=mysqli_query($db,$query);
                              if ($qr==false) {
                                  echo "Failed to get candidate information from fakulti section<br>";
                                  echo "SQL error :".mysqli_error($db);
                              }
                              $record=mysqli_fetch_array($qr);
                              $name=$record['voter_name'];
							  $motto=$record['candidate_motto'];
                          ?> 
                          <tr>
                            <td><?=$candidate_id?></td>            
                            <td><?=$name?></td>
							<td><?=$motto?></td>
                          </tr>
                          <!-- close loop -->
                          <?php }?>
                        </table>
                      </div>
                </div>
                 <button class="btn btn-secondary " name="btn_back" type="button"value="Back" onclick="history.back()">Back</button>
                 <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#confirmationmodal">Submit</button>
 
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

            <!-- Confirmation  Modal-->
            <div class="modal fade" id="confirmationmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Are you sure ?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">×</span>
                    </button>
                  </div>
                  <div class="modal-body">You cannot change after you continue</div>
                  <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-danger" href="insertvotingintoDB.php">Continue</a>
                  </div>
                </div>
              </div>
            </div>
</body>
</html>
<?php include 'include/footer_votingpage.php' ?>