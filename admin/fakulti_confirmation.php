<?php session_start();
$electionid=$_SESSION['electionid'];

//If your session isn't valid, it returns you to the login screen for protection
if(empty($_SESSION['id'])){
 header("location:../index.php");
}
include '../connection.php';

 // push candidate data to database
  // check if the 'voterid' variable is set in URL
  if (isset($_GET['voterid'])){

      // get id value
      $voterid = $_GET['voterid'];
      // to get candidate information from database
    $sql="SELECT * from voter WHERE voter_id= $voterid";
    $voterdetail=mysqli_query($db,$sql);
    if ($voterdetail==false) {
    echo "Failed to get voter information fakulti 2<br>";
    echo "SQL error :".mysqli_error($db);
    }
    else
       $rekod=mysqli_fetch_array($voterdetail);

    $voter_id =$rekod['voter_id'];
    $voter_name =$rekod['voter_name'];
    $voter_faculty =$rekod['faculty'];
      // insert voter data into candidate table in DB
      $sql="INSERT INTO candidate (voter_id,section_id,election_id) VALUES ('$voterid','$voter_faculty','$electionid')";
      $qr=mysqli_query($db,$sql);

      if ($qr==true){
        // get last inserted candidate id from database
        $candidate_id = mysqli_insert_id($db);
        // to add into count database
        $sql="INSERT INTO count (candidate_id,section_id,election_id) VALUES ('$candidate_id','$voter_faculty','$electionid')";
        $qr=mysqli_query($db,$sql);
        if ($qr==false) {
          echo "Failed to add candidate to count table<br>";
          echo "SQL error :".mysqli_error($db);
          exit();
        }
        else 
        // redirect to candidate list page after succesfully insett data into DB 
        header('Location: candidatefakulti.php?success=addcandidate');
      }
      else{
        echo "Fail to add as candidate for $voterid";
        echo mysqli_error($db);
        exit();
      }
      // redirect back to candidates
        // header("Location: candidateumum.php");
   }

$voterid=$_GET['voter_id'];

// check if voter already a candidate
$query="SELECT voter_id, section_id from candidate WHERE voter_id= '$voterid' AND election_id = '$electionid' ";
$qr=mysqli_query($db,$query);
if ($qr==false) {
    echo "Failed to check if voter already a candidate <br>";
    echo "SQL error :".mysqli_error($db);
  }
  $checkinDB=mysqli_fetch_array($qr);

// check the voter id if exist in candidate DB
if (mysqli_num_rows($qr)>0) {
  if ($checkinDB['section_id']==0) {
      header( "Location: fakulti_voterlist.php?error=alreadyumumcandidate" );
  }
  elseif ($checkinDB['section_id']>0) {
      header( "Location: fakulti_voterlist.php?error=alreadyfacultycandidate" );
  }
  else
      header( "Location: fakulti_voterlist.php?error=alreadycandidate" );
}
else {
// to get voter information from database
    $query="SELECT v.*,f.name
            FROM voter as v 
            JOIN faculty as f 
            ON v.faculty=f.faculty_id
            WHERE voter_id= $voterid ";
    $voterdetail=mysqli_query($db,$query);
    if ($voterdetail==false) {
    echo "Failed to get voter information fakulti 1<br>";
    echo "SQL error :".mysqli_error($db);
    }
    $rekod=mysqli_fetch_array($voterdetail);


include "include/header.template.php";

?>
            <!-- align element to center -->
            <div align="center">
            <!-- Start card element -->
            <div class="col-xl-7 col-lg-7">
              <div class="card shadow mb-4">
                <!-- Card Header -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">Tambah sebagai calon fakulti? </h6>
                  <!-- Card Header End -->
                </div>

                <!-- Card Body -->
                <div class="card-body ">
                    <table class="table table-bordered">
                      <thead>
                        <tr>
                          <th class="th-sm">Matric No</th>
                          <th class="th-sm">Section</th>
                          <th class="th-sm">Name</th>
                          <th class="th-sm">Faculty</th>
                        </tr>
                      </thead>   
                      <tbody>
                        <tr>
                          <td><?=$rekod['matric_no']?></td>
                          <td> Fakulti</td>
                          <td><?=$rekod['voter_name']?></td>
                          <td><?=$rekod['name']?></td>
                        </tr>
                      </tbody>
                    </table>
                  <a href="candidatefakulti.php"> <button name="btn_no" class="btn btn-danger">Cancel</button></a>
                  <a href="fakulti_confirmation.php?voterid=<?php echo $voterid?>"><button name="btn_yes" class="btn btn-primary">Tambah</button></a>
                <!-- Card Body End -->
                </div>
              </div>
              <!-- end card div -->
            </div>
            <!-- end center element -->
            </div>
<?php
include "include/footer.template.php";

 }

?>