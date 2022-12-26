<?php include 'db_connect.php' ?>
<?php

if(isset($_GET['attendance_id'])){
	// echo "SELECT * FROM attendance_list where id = {$_GET['attendance_id']}";
$qry = $conn->query("SELECT * FROM attendance_list where id = {$_GET['attendance_id']}");
foreach($qry->fetch_array() as $k => $v){
	$$k = $v;
}
}

?>
<div class="container-fluid">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-header"><b>Check Attendance</b></div>

			<div class="card-body">
				<form id="manage-attendance">
					<input type="hidden" name="id" value="<?php echo isset($id) ? $id : '' ?>">
					<div class="row justify-content-center">
						<label for="" class="mt-2">Class per units</label>
						<div class="col-sm-4">
				            <select name="class_unit_id" id="class_unit_id" class="custom-select select2 input-sm">
				                <option value=""></option>
				                <?php
				                $class = $conn->query("SELECT cs.*,concat(co.course,' ',c.level,'-',c.section) as `class`,s.unit,f.name as fname FROM class_unit cs inner join `class` c on c.id = cs.class_id inner join courses co on co.id = c.course_id inner join faculty f on f.id = cs.faculty_id inner join units s on s.id = cs.unit_id ".($_SESSION['login_faculty_id'] ? " where f.id = {$_SESSION['login_faculty_id']} ":"")." order by concat(co.course,' ',c.level,'-',c.section) asc");
				                while($row=$class->fetch_assoc()):
				                ?>
				                <option value="<?php echo $row['id'] ?>" data-cid="<?php echo $row['id'] ?>" <?php echo isset($class_unit_id) && $class_unit_id == $row['id'] ? 'selected' : (isset($class_unit_id) && $class_unit_id == $row['id'] ? 'selected' :'') ?>><?php echo $row['class'].' '.$row['unit']. ' [ '.$row['fname'].' ]' ?></option>
				                <?php endwhile; ?>
				            </select>
						</div>
						<div class="col-sm-3">
							<input type="date" name="doc" id="date_selected" value="<?php echo isset($doc) ? date('Y-m-d',strtotime($doc)) :date('Y-m-d') ?>" class="form-control">
						</div>
						<button onclick="openFaceRecognition();" type="button" id="face_recognition_button" style="height: auto; padding: 10px; font-size: 16px; width: auto; outline: black; border:  1px solid black; background: #17a2b873; color: black; display: none;"><img src="assets/uploads/ic_face_recognition.png" style="height: 20px; width:20px; color: black;"> Start face recogniton</button>
					</div>

					<hr>
					<div class="row">
						<div class="col-md-12" id='att-list'>
							<center><b><h4><i>Please Select Class First.</i></h4></b></center>
						</div>

						<div class="col-md-12"  style="display: none" id="submit-btn-field">
								

							<center>

								<button class="btn btn-primary btn-sm col-sm-5">Save</button>
							</center>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
var tableToExcel = (function() {
  var uri = 'data:application/vnd.ms-excel;base64,'
    , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--><meta http-equiv="content-type" content="text/plain; charset=UTF-8"/></head><body><table>{table}</table></body></html>'
    , base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) }
    , format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) }
  return function(table, name) {
    if (!table.nodeType) table = document.getElementById(table)
    var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML}
    window.location.href = uri + base64(format(template, ctx))
  }
})()


</script>


<div id="table_clone" style="display: none">

	<table class='table table-bordered table-hover'>

		<thead>
			<tr>
				<th>#</th>
				<th>Student</th>
				<th>Attendance</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
</div>

<div id="chk_clone" style="display: none">


	<div class="d-flex justify-content-center chk-opts">
		<div class="form-check form-check-inline">
		  <input class="form-check-input present-inp" type="checkbox" value="1">
		  <label class="form-check-label present-lbl">Present</label>
		</div>
		<div class="form-check form-check-inline">
		  <input class="form-check-input absent-inp" type="checkbox" value="0">
		  <label class="form-check-label absent-lbl">Absent</label>
		</div>
		<div class="form-check form-check-inline">
		  <input class="form-check-input late-inp" type="checkbox" value="2">
		  <label class="form-check-label late-lbl">Late</label>
		</div>
	</div>
</div>
<style>
	.present-inp,.absent-inp,.late-inp,.present-lbl,.absent-lbl,.late-lbl{
		cursor: pointer;
	}
</style>
<script>
	var attendance_id_new = "<?php echo isset($id) ? $id : '' ?>";

$(document).ready(function(){

	if('<?php echo isset($class_unit_id) ? 1 : 0 ?>' == 1){
		start_load()
		$.ajax({
			url:'ajax.php?action=get_class_list',
			method:'POST',
			data:{class_unit_id:$('#class_unit_id').val(),doc:$('#doc').val(),att_id :'<?php echo isset($id) ? $id : '' ?>' },
			success:function(resp){
				//alert("Got");
				if(resp){
					
					resp = JSON.parse(resp)
					var _table = $('#table_clone table').clone()
					$('#att-list').html('')
					$('#att-list').append(_table)
					var _type = ['Absent','Present','Late'];
					var data = resp.data;
					var record = resp.record;
					var attendance_id = !!resp.attendance_id ? resp.attendance_id : '';
					
					
					if(Object.keys(data).length > 0){
						var i = 1;
						Object.keys(data).map(function(k){
							var name = data[k].name;
							var id = data[k].id;
							var tr = $('<tr></tr>')
							var opts = $('#chk_clone').clone()

							opts.find('.present-inp').attr({'name':'type['+id+']','id':'present_'+id})
							opts.find('.absent-inp').attr({'name':'type['+id+']','id':'absent_'+id})
							opts.find('.late-inp').attr({'name':'type['+id+']','id':'late_'+id})

							opts.find('.present-lbl').attr({'for':'present_'+id})
							opts.find('.absent-lbl').attr({'for':'absent_'+id})
							opts.find('.late-lbl').attr({'for':'late_'+id})

							tr.append('<td class="text-center">'+(i++)+'</td>')
							tr.append('<td class="">'+(name)+'</td>')
							var td = '<td>';
								td += '<input type="hidden" name="student_id['+id+']" value="'+id+'">';
								td += opts.html();
								td += '</td>';
							tr.append(td)

							_table.find('tbody').append(tr)
						})
						$('#submit-btn-field').show()
						$('#edit_att').attr('data-id',attendance_id)
					}else{
							var tr = $('<tr></tr>')
							tr.append('<td class="text-center" colspan="3">No data.</td>')
							_table.find('tbody').append(tr)
						$('#submit-btn-field').attr('data-id','').hide()
						$('#edit_att').attr('data-id','')
					} 
					$('#att-list').html('')
					$('#att-list').append(_table)
					if(Object.keys(record).length > 0){
						Object.keys(record).map(k=>{
							// console.log('[name="type['+record[k].student_id+']"][value="'+record[k].type+'"]')
							$('#att-list').find('[name="type['+record[k].student_id+']"][value="'+record[k].type+'"]').prop('checked',true)
						})
					}
				}
			},
			complete:function(){
				$("input:checkbox").on('keyup keypress change',function(){
				    var group = "input:checkbox[name='"+$(this).attr("name")+"']";
				    $(group).prop("checked",false);
				    $(this).prop("checked",true);
				});
				$('#edit_att').click(function(){
					location.href = 'index.php?page=check_attendance&attendance_id='+$(this).attr('data-id')
				})
				end_load()
			}
		})
	}
	
})
	$('#class_unit_id').change(function(){
		get_data($(this).val())
	})
	window.get_data = function(id){
		start_load()
		$.ajax({
			url:'ajax.php?action=get_class_list',
			method:'POST',
			data:{class_unit_id:id},
			success:function(resp){
				document.getElementById("face_recognition_button").style.display = "block";
				if(resp){

					resp = JSON.parse(resp)
					var _table = $('#table_clone table').clone()
					$('#att-list').html('')
					$('#att-list').append(_table)
					if(Object.keys(resp).length > 0){
						var i = 1;
						Object.keys(resp.data).map(function(k){

							var name = resp.data[k].name;
							var id = resp.data[k].id;
							var tr = $('<tr></tr>')
							var opts = $('#chk_clone').clone()
							opts.find('.present-inp').attr({'name':'type['+id+']','id':'present_'+id})
							opts.find('.absent-inp').attr({'name':'type['+id+']','id':'absent_'+id})
							opts.find('.late-inp').attr({'name':'type['+id+']','id':'late_'+id})

							opts.find('.present-lbl').attr({'for':'present_'+id})
							opts.find('.absent-lbl').attr({'for':'absent_'+id})
							opts.find('.late-lbl').attr({'for':'late_'+id})

							tr.append('<td class="text-center">'+(i++)+'</td>')
							tr.append('<td class="">'+(name)+'</td>')
							var td = '<td>';
								td += '<input type="hidden" name="student_id['+id+']" value="'+id+'">';
								td += opts.html();
								td += '</td>';
							tr.append(td)

							_table.find('tbody').append(tr)
						})
						$('#submit-btn-field').show()
					}else{
							var tr = $('<tr></tr>')
							tr.append('<td class="text-center" colspan="3">No data.</td>')
							_table.find('tbody').append(tr)
						$('#submit-btn-field').hide()
					} 
					$('#att-list').html('')
					$('#att-list').append(_table)
				}
			},
			complete:function(){
				$("input:checkbox").on('keyup keypress change',function(){
					// console.log(test)
				    var group = "input:checkbox[name='"+$(this).attr("name")+"']";
				    $(group).prop("checked",false);
				    $(this).prop("checked",true);
				});
				end_load()
			}
		})
	}
	$('#manage-attendance').submit(function(e){
		e.preventDefault()
		start_load()
		$.ajax({
			url:'ajax.php?action=save_attendance',
			method:'POST',
			data:$(this).serialize(),
			success:function(resp){
				if(resp==1){
					  alert_toast("Data successfully saved.",'success')
                        setTimeout(function(){
                            location.reload()
                        },1000)
				}else if(resp ==2){
					  alert_toast("Class already has an attendance record with the slected unit and date.",'danger')
					  end_load();
				}
			}
		})
	})


	function openFaceRecognition(){
		var date_selected = document.getElementById('date_selected').value;
		//alert($('#class_unit_id').val());
		alert_toast("Face recognition triggered...");
		start_load();
		
		$.ajax({
			url:'../../apis/trigger-camera.php',
			data: {attendance_id:$('#class_unit_id').val(),date_selected:date_selected},
			method:'POST',
			success:function(resp){
				alert_toast(resp);
				end_load();
				location.reload()
			},
			error:function(resp){
				alert_toast("Something went wrong...");
				end_load();
			}
		})
	}
</script>