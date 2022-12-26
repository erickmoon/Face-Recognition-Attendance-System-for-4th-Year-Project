<?php 
include 'db_connect.php'; 
if(isset($_GET['id'])){
$qry = $conn->query("SELECT * FROM students where id= ".$_GET['id']);
foreach($qry->fetch_array() as $k => $val){
    $$k=$val;
}
}
?>
<div class="container-fluid">
    <form  method="post" action="" id="manage-student" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<?php echo isset($id) ? $id : '' ?>">
        <div id="msg" class="form-group"></div>
        <div class="form-group">
            <label for="" class="control-label">ID #</label>
            <input type="text" class="form-control" name="id_no"  value="<?php echo isset($id_no) ? $id_no :'' ?>" required>
        </div>
        <div class="form-group">
            <label for="" class="control-label">Student name</label>
            <input type="text" class="form-control" name="name"  value="<?php echo isset($name) ? $name :'' ?>" required>
        </div>
        <div class="form-group">
            <label for="" class="control-label">Student photo</label>
            <input accept="image/*" onchange="parseImage('student_photo','student_photo_element')" type="file" class="form-control" id="student_photo_element" name="student_photo" required>
            <img  id="student_photo" onerror="hideTag()" src="../../images/<?php echo isset($student_photo) ? $student_photo :'' ?>" style="height: 100px; width: 100px; margin-top: 10px; border: 1px solid black;">
            <script type="text/javascript">
                function hideTag(){
                    document.getElementById("student_photo").style.display = "none";
                }
                function parseImage(image_view,input_file){
                    document.getElementById(image_view).style.display = "block";
                  
                    var input = document.getElementById(input_file);
                    var file = input.files[0];
                
                
                    var file_data = $('#'+input_file).prop('files')[0];   
                    var form_data = new FormData();        
                    form_data.append('file', file_data);
                    form_data.append('image_name', input_file);

                    var readerURL = new FileReader();

                    readerURL.onload = function() {
                            
                      $("#"+image_view).attr('src', readerURL.result);

                      return true;
                    };

                    readerURL.readAsDataURL(file);
                      
                    
                }
            </script>
        </div>
        <div class="form-group">
            <label for="" class="control-label">Class</label>
            <select name="class_id" id="" class="custom-select select2">
                <option value=""></option>
                <?php
                $class = $conn->query("SELECT c.*,concat(co.course,' ',c.level,'-',c.section) as `class` FROM `class` c inner join courses co on co.id = c.course_id order by concat(co.course,' ',c.level,'-',c.section) asc");
                while($row=$class->fetch_assoc()):
                ?>
                <option value="<?php echo $row['id'] ?>" <?php echo isset($class_id) && $class_id == $row['id'] ? 'selected' : '' ?>><?php echo $row['class'] ?></option>
                <?php endwhile; ?>
            </select>
        </div>
    </form>
</div>
<script>
    $('#manage-student').on('reset',function(){
        $('#msg').html('')
        $('input:hidden').val('')
    })

    $('#manage-student').submit(function(e){
        e.preventDefault()
        start_load()
        $('#msg').html('')
        $.ajax({
            url:'ajax.php?action=save_student',
            data: new FormData($(this)[0]),
            cache: false,
            contentType: false,
            processData: false,
            method: 'POST',
            type: 'POST',
            success:function(resp){
                if(resp==1){
                    alert_toast("Data successfully saved.",'success')
                        setTimeout(function(){
                            location.reload()
                        },1000)
                }else if(resp == 2){
                $('#msg').html('<div class="alert alert-danger mx-2">ID # already exist.</div>')
                end_load()
                }else {
                    alert_toast("Data successfully saved.",'success')
                        setTimeout(function(){
                            location.reload()
                        },1000) 
                }  
            }
        })
    })

    $('.select2').select2({
        placeholder:"Please Select here",
        width:'100%'
    })
</script>