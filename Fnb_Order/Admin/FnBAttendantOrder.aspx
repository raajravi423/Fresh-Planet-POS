<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="FnBAttendantOrder.aspx.cs" Inherits="Fnb_Order.Admin.FnBAttendantOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="Style/Fnb_Atten_Order.css" rel="stylesheet" /> 
    <script type="text/javascript">

        $(document).ready(function () {
            BindServices('All')
            $('#txtbedno').focus();
            $('#txtdoe').datepicker({
                minDate: new Date(),
                controlType: 'select',
                showTime: true,
                onCreate: function (inst) {
                    $(inst.dpDiv).draggable();
                },
                dateFormat: 'dd/mm/yy'
            });
            $('#txtdod').datepicker({
                minDate: new Date(),
                controlType: 'select',
                showTime: true,
                onCreate: function (inst) {
                    $(inst.dpDiv).draggable();
                }, dateFormat: 'dd/mm/yy'

            });

            $('#txtbedno').keypress(function (e) {
                // e.preventDefault();
                var key = e.which;
                if (key == 13)  // the enter key code
                {
                    $("#btnSearch").click();
                    return false;
                }
                else {
                    return true;
                }
            });

            $("#btnSearch").on("click", function () {
                $("#dvpatdetails").hide('10000');
                $("#dvitemlist").hide('10000');
                $("#dvitemlistheader").attr("itemstring", '')
                $("#itemidetail").empty();
                $("#dvpreviewreceipt").hide('10000');
                $("#spnsubtotalamt").empty();
                $("#spncgstdetails").empty();
                $("#spnsgstdetails").empty();
                $("#spngtotal").empty();

                var bedno = $("#txtbedno").val();

                if (bedno == ' ' || bedno == '') {
                    $("#txtbedno").css("border", "1px solid red");
                    alert("Bed Number is Required.");
                    $("#dvpatdetails").hide('10000');
                    $("#dvitemlist").hide('10000');

                }
                else {
                    $("#txtbedno").css("border", "1px solid #ccc");
                    if (CheckSession() == true) {
                        GetPatientDetails(bedno);
                      

                    }
                    else {
                        window.location = "../Login.aspx";
                    }

                }
            });

            $(".items").live("click", function () {
                var itemid = $(this).attr("itemcode");
                if (CheckSession() == true) {
                    if (confirm('Are You Sure Want to Delete This Item.?') == true) {


                    var itmstrng = $("#dvitemlistheader").attr('itemstring');
                    var arritem = itmstrng.split('^');
                    var newstr = '';
                    for (var i = 0; i < arritem.length; i++)
                    {
                        if (arritem[i].startsWith(itemid) == false) {
                            if (newstr == '') {
                                newstr = arritem[i];
                            }
                            else {
                                newstr = newstr + "^" + arritem[i];
                            }
                        }
                        else {

                        }
                    }
                 
                    Binditemingridview(newstr);
                        

                }
                }
            });
         
            // Filter Services With Alphatic Wise
            $(".filt_service").live("click", function () {
                var thistext = $(this).text();
               
                if(CheckSession() == true){                    
                   
                        BindServices(thistext);
                }
            });

            $(".grid_row").live("click", function () {
                var itemid = $(this).attr("id")
                var rate = $(this).attr("rate");
                var itemname = $(this).find("#spnname" + itemid + "").text();
                var qty = $(this).find("#ddlqty" + itemid + "").val();
              
                if (CheckSession() == true) {
                    $("#itemidetail").empty();
                    var itmquerystring = "";
                    itmquerystring = $("#dvitemlistheader").attr("itemstring");
                    if ($("#ddlqty" + itemid + "").val() != '0') {
                        $("#ddlfooditem").css("border", "1px solid #ccc");
                        $("#ddlqty").css("border", "1px solid #ccc");
                        if (itmquerystring == '') {
                            itmquerystring = itemid + "$" + itemname + "$" + rate + "$" + qty;
                        }
                        else {
                            itmquerystring = itmquerystring + "^" + itemid + "$" + itemname + "$" + rate + "$" + qty;
                        }
                        Binditemingridview(itmquerystring);
                        $("#ddlfooditem").val('0');
                        $("#ddlqty").val("1");
                    }
                    else {
                        var alertmsg = '';
                        if ($("#ddlfooditem").val() == '0') {
                            $("#ddlfooditem").css("border", "1px solid red");
                            alertmsg = alertmsg + "\nFood Item Is Required.";
                        }
                        else {
                            $("#ddlfooditem").css("border", "1px solid #ccc");

                        }
                        if ($("#ddlqty").val() == '0') {
                            $("#ddlqty").css("border", "1px solid red");
                            alertmsg = alertmsg + "\nQuantity Is Required.";
                        }
                        else {
                            $("#ddlqty").css("border", "1px solid #ccc");

                        }
                        if (alertmsg != ' ' || alertmsg != '') {
                            alert(alertmsg);
                        }
                    }
                }


            });
            $("#btnadditem").on("click", function () {
                if(CheckSession() == true){
                    $("#itemidetail").empty();
                    var itmquerystring = "";
                        itmquerystring  = $("#dvitemlistheader").attr("itemstring");
                        if ($("#ddlfooditem").val() != '0' && $("#ddlqty").val() != '0') {
                            $("#ddlfooditem").css("border", "1px solid #ccc");
                            $("#ddlqty").css("border", "1px solid #ccc");
                        if(itmquerystring == '') {
                            itmquerystring = $("#ddlfooditem option:selected").attr("value") + "$" + $("#ddlfooditem option:selected").text() + "$" + $("#ddlfooditem option:selected").attr("price") + "$" + $("#ddlqty option:selected").val();                          
                        }
                        else {
                            itmquerystring = itmquerystring + "^" + $("#ddlfooditem option:selected").attr("value") + "$" + $("#ddlfooditem option:selected").text() + "$" + $("#ddlfooditem option:selected").attr("price") + "$" + $("#ddlqty option:selected").val();
                        }
                        Binditemingridview(itmquerystring);
                        $("#ddlfooditem").val('0');
                        $("#ddlqty").val("1");
                    }
                    else {
                        var alertmsg = '';
                        if ($("#ddlfooditem").val() == '0') {
                            $("#ddlfooditem").css("border", "1px solid red");
                            alertmsg = alertmsg + "\nFood Item Is Required.";
                        }
                        else {
                            $("#ddlfooditem").css("border", "1px solid #ccc");

                        }
                        if ($("#ddlqty").val() == '0') {
                            $("#ddlqty").css("border", "1px solid red");
                            alertmsg = alertmsg + "\nQuantity Is Required.";
                        }
                        else {
                            $("#ddlqty").css("border", "1px solid #ccc");

                        }
                        if (alertmsg != ' ' || alertmsg != '')
                        {
                            alert(alertmsg);
                        }
                    }
                }
            });

            $("#btngenratebill").on("click", function () {
                
                if (CheckSession() == true) {
                    $.ajax({
                        type: 'POST',
                        url: '/Admin/FnBAttendantOrder.aspx/GenrateBill',
                        data: JSON.stringify({ BEDNo: $("#txtbedno").val(), UHID: $("#dvuhid").text(), IPID: $("#dvipid").text(), PatientName: $("#dvpatname").text(), Age: $("#dvpatage").text(), AttendantName: $("#txtattname").val(), DeliveryLocation: $("#txtdelloc").val(), DOE: $("#txtdoe").val(), DOD: $("#txtdod").val(), Itemstring: $("#dvitemlistheader").attr('itemstring'), SubTotal: $("#spnsubtotalamt").text(), CGST: $("#spncgstdetails").text(), SGST: $("#spnsgstdetails").text(), GTotal: $("#spngtotal").text()}),
                        dataType: 'json',
                        contentType: 'application/json;charset=utf-8',
                        async: false,
                        success: function (data) {
                            if (data.d != "-")
                            {
                             //   GenrateReceiptNumber();
                                $("#spnmsg").text("Bill Genrated Successfully.");
                                $("#spnmsg").css("color", "green");
                                window.open("CReport/Print.aspx?Flg=S1&IPID=" + $("#dvipid").text() + "^"+data.d+"", '_blank');
//                                window.location.href = "CReport/Print.aspx?Flg=S1&IPID=" + $("#dvipid").text() + "^"+data.d+"";
                              
                            }

                        }
                    });

                }
                else {
                    window.location('../Login.aspx');
                }

            });

        });

        // Method Definition For Bind Services
        function BindServices(search_key) {
            $.ajax({
                type: 'POST',
                url: '/Admin/FnBAttendantOrder.aspx/GetItemList',
                data: JSON.stringify({SearchKeyword: search_key }),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                async: true,
                cache: false,
                success: function (data) {
                    $("#dv_services").empty();
                    if (data.d.length > 0) {
                        if (data.d[0].ErrorID == null) {
                            var sr = 0;
                            for (var i = 0; i < data.d.length; i++) {
                                sr = sr + 1;
                                if (i % 2 == 0) {
                                    $("#dv_services").append("<div id='" + data.d[i].ItemID + "' class='grid_odd_row grid_row' rate='" + data.d[i].Price + "' title='Category :-" + data.d[i].Category + "\n Price :-" + data.d[i].Price + "'><div style='width:82%;float:left;'>" + sr + ". <span id='spnname" + data.d[i].ItemID + "'> " + data.d[i].ItemName + "</span></div><div style='width:18%;float:left;'><div class='row2'><div style='width:49%;float:left;'>QTY :</div><div style='width:49%;float:left;'><select id='ddlqty" + data.d[i].ItemID + "'  data-fieldtype='Select' class='input-with-feedback form-control' style='padding:0px;' type='text'><option value='0'>Select</option><option selected='selected' value='1'>01</option><option value='2'>02</option><option value='3'>03</option><option value='4'>04</option><option value='5'>05</option><option value='6'>06</option><option value='7'>07</option><option value='8'>08</option><option value='9'>09</option><option value='10'>10</option></select></div></div><div style='float:left;overflow:auto;'></div>");
                                    //<img alt='ADD' css='additem' src='../Images/food.png' style='width:16px;height:16px;'/>
                                }
                                else {
                                    $("#dv_services").append("<div id='" + data.d[i].ItemID + "' class='grid_even_row grid_row' rate='" + data.d[i].Price + "' title='Category :-" + data.d[i].Category + "\n Price :-" + data.d[i].Price + "'><div style='width:82%;float:left;'>" + sr + ". <span id='spnname" + data.d[i].ItemID + "'> " + data.d[i].ItemName + "</span></div><div style='width:18%;float:left;'><div class='row2'><div style='width:49%;float:left;'>QTY :</div><div style='width:49%;float:left;'><select id='ddlqty" + data.d[i].ItemID + "'  data-fieldtype='Select' class='input-with-feedback form-control' style='padding:0px;' type='text'><option value='0'>Select</option><option selected='selected' value='1'>01</option><option value='2'>02</option><option value='3'>03</option><option value='4'>04</option><option value='5'>05</option><option value='6'>06</option><option value='7'>07</option><option value='8'>08</option><option value='9'>09</option><option value='10'>10</option></select></div></div><div style='float:left;overflow:auto;'></div>");
                                    //<img alt='ADD' css='additem' src='../Images/food.png' style='width:16px;height:16px;'/>
                                }
                            }
                        }
                        else {
                            window.location = "../ErrorPage.aspx?ErrorID=" + data.d[0].ErrorID + "";
                        }
                    }
                },
                error: function (result) {
                    alert("System Error Occured.");
                },
                error: function () { }
            });



        }
        function Binditemingridview(_newstr) {
            $("#dvitemlistheader").attr("itemstring", _newstr);
            var itmquerystring1 = $("#dvitemlistheader").attr("itemstring");
            var splttditm = itmquerystring1.split('^');
            if (splttditm.length > 0) {             
                $("#dvpreviewreceipt").show('10000');
            }
            else if(itmquerystring1 == " ") {
                $("#dvpreviewreceipt").hide('10000');
            }
            $("#itemidetail").empty();
            var totalamt = 0.00;
            if (itmquerystring1 != '') {
                for (var i = 0 ; i < splttditm.length ; i++) {
                    var splttditmdetail = splttditm[i].split('$');
                    var sr = i + 1;
                    totalamt = totalamt + splttditmdetail[2] * splttditmdetail[3];
                    if (i % 2 == 0)
                    {
                        $("#itemidetail").append(" <div class ='row1 grid_odd_row'><div style='float:left;width:8%;'>" + sr + ".</div><div style='float:left;width:50%;'>" + splttditmdetail[1] + "</div><div style='float:left;width:10%;'>" + splttditmdetail[2] + "</div><div style='float:left;width:10%;'>" + splttditmdetail[3] + "</div><div style='float:left;width:10%;' class='itemamt'>" + splttditmdetail[2] * splttditmdetail[3] + "</div><div style='float:left;width:8%;'><img src='../Images/del.png' alt='Delete' title='Delete Item.' class='items' itemcode='" + splttditmdetail[0] + "' style='width:16px;height:16px;'></div></div>");
                    }
                    else
                    {
                        $("#itemidetail").append(" <div class ='row1 grid_even_row'><div style='float:left;width:8%;'>" + sr + ".</div><div style='float:left;width:50%;'>" + splttditmdetail[1] + "</div><div style='float:left;width:10%;'>" + splttditmdetail[2] + "</div><div style='float:left;width:10%;'>" + splttditmdetail[3] + "</div><div style='float:left;width:10%;' class='itemamt'>" + splttditmdetail[2] * splttditmdetail[3] + "</div><div style='float:left;width:8%;'><img src='../Images/del.png' alt='Delete' title='Delete Item.' class='items' itemcode='" + splttditmdetail[0] + "' style='width:16px;height:16px;'></div></div>");
                    }
                    }
                var subitem = 0;
            }
            $("#spnsubtotalamt").text(totalamt);
            $("#spncgstdetails").text((totalamt * 9 / 100).toFixed(2));
            $("#spnsgstdetails").text((totalamt * 9 / 100).toFixed(2));
            var gtotal  = 0.00;
            gtotal = ((totalamt) +(totalamt * 9 / 100) + (totalamt * 9 / 100)).toFixed(2);
            $("#spngtotal").text(gtotal);
            $("#spnbtngtotal").text(gtotal);
            
       }
        function GetCurrentDate() {
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1;
            var yyyy = today.getFullYear();
            if (dd < 10) {
                dd = '0' + dd;
            }
            if (mm < 10) {
                mm = '0' + mm;
            }
            return dd + '/' + mm + '/' + yyyy;
        }
        function GetPatientDetails(_bedno) {
            $.ajax({
                type: 'POST',
                url: '/Admin/FnBAttendantOrder.aspx/GetPatientDetails',
                data: JSON.stringify({ BedNo: _bedno }),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        $("#dvuhid").text(data.d[0].UHID);
                        $("#dvipid").text(data.d[0].IPID);
                        $("#dvpatname").text(data.d[0].PATIENTNAME);
                        $("#dvpatage").text(data.d[0].AGE);
                        $("#txtattname").val(data.d[0].ATTENDANTNAME);
                        $("#txtdelloc").val(data.d[0].LOCATION);
                        $("#txtdoe").val(GetCurrentDate());
                        $("#txtdod").val(GetCurrentDate());
                        $("#dvpatdetails").show('10000');
                        $("#dvitemlist").show('10000');
                    }
                    else {
                        $("#dvpatdetails").hide('10000');
                        $("#dvitemlist").hide('10000');
                        alert("Sorry! Patient Details Does Not Exists.\n Kindly Try Again With Valid Bed Number ");

                        $("#dvuhid").text('');
                        $("#dvipid").text('');
                        $("#dvpatname").text('');
                        $("#dvpatage").text('');
                        $("#txtattname").val('');
                        $("#txtdelloc").val('');
                        $("#txtdoe").removeAttr("readonly");
                        $("#txtdod").removeAttr("readonly");
                        $("#txtdoe").val('');
                        $("#txtdod").val('');
                        //$("#txtdoe").datepicker("setDate", null);
                        //$("#txtdod").datepicker("setDate", null);

                        //$("#txtdoe").removeAttr("readonly").val('');
                        //$("#txtdod").removeAttr("readonly").val('');
                    }
                }
            });

        }
        function GetFoodItem() {
            $.ajax({
                type: 'POST',
                url: '/Admin/FnBAttendantOrder.aspx/GetItemList',
                data: JSON.stringify({}),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                async: false,
                success: function (data) {
                    $("#ddlfooditem").empty();
                    $("#ddlfooditem").append("<option value ='0'>Select</option>");
                    if (data.d.length > 0)

                        for (var i = 0 ; i < data.d.length; i++)
                        {
                            $("#ddlfooditem").append("<option value ='" + data.d[i].ItemID + "' title=' Item Category : " + data.d[i].Category + "\n Price : " + data.d[i].Price + ".' price='" + data.d[i].Price + "'>" + data.d[i].ItemName + "</value>")
                        }
                }
            });

        }
        function CheckSession() {
            var retval;
            $.ajax({
                type: 'POST',
                url: '/Admin/FnBAttendantOrder.aspx/CheckSession',
                data: JSON.stringify({}),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                async: false,
                success: function (data){
                    retval = data.d;
                }
            });
            return retval;
        }
        

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <div id="dvITTransaction" class="main-content">
        <div class="row dv-header">
            <div class="main-header-text">Genrate Order</div>
        </div>
        <center>
        <div class="main-body-content" style="width:1200px;overflow:auto;margin:20px;padding-top:20px;padding-bottom:20px;" >
            <div class="row1"><span id="spnmsg"></span> </div>
            <div id="dvpatientdetails" style ="width:100%;float:left;overflow:auto;">
                <div style="width:100%;overflow:auto;height:auto;">
                    <div class="row1" style="width:98%;border:1px solid #ccc;background-color:InactiveBorder;">
                 <div class="row1">
             <span class="box-header">Search Detail:</span>
             </div>
                 <div  style="width:98%;overflow:auto;margin-bottom:15px;">
                 <div style="width:45%;float:left;text-align:right;line-height:30px;">Bed Number :</div>
                 <div style="width:25%;float:left;text-align:left;margin-left:20px;"><input type="text" id="txtbedno" class="form-control"  placeholder="Bed No Ex. 2XX2" maxlength="6"/> </div>
                 <div style="width:15%;float:right;text-align:left;"><img src="../Images/search.png" id="btnSearch" alt="Search" title="Search Patient" style="cursor:pointer;width:30px;height:30px" /> </div>
                 </div>

                </div>               
                </div>
                <div id="dvpatdetails" class="row1" style="display:none;margin-top:10px;margin-bottom:10px;border:1px solid #ccc;background-color:#D3EEE6;width:98%;">
                <div class="row1" style="width:48%;float:left; margin-left:12px;margin-right:11px;">
                    <div class="row1">
             <span class="box-header">Patient Detail:</span>
             </div>

                    <div class="row1" >
                        <div style="width:45%;float:left;">
                        <div style="width:45%;float:left;text-align:right;line-height:30px;">UHID &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</div>
                        <div  class="lbl-field" id="dvuhid"></div>
                    </div>
                    <div style="width:45%;float:left;">
                        <div style="width:45%;float:left;text-align:right;line-height:30px;">IPID :</div>
                        <div class="lbl-field" id="dvipid"></div>
                        </div>
                    </div>
                    <div class="row1" style="margin-bottom:15px;">
                        <div style="width:45%;float:left;">
                        <div style="width:45%;float:left;text-align:right;line-height:30px;">Patient Name :</div>
                        <div  class="lbl-field" id="dvpatname"></div>
                    </div>
                    <div style="width:45%;float:left;">
                    <div style="width:45%;float:left;text-align:right;line-height:30px;">Age :</div>
                    <div class="lbl-field" id="dvpatage"></div>
                    </div>
                    </div>
             
                               
             </div>
                <div class="row1" style="width:48%;float:left; margin-right:10px;margin-left:10px;">
             <div class="row1">
             <span class="box-header">Order Detail:</span>
             </div>
<div class="row1" style="margin-bottom:10px;">
                        <div style="width:98%;float:left;">
                        <div style="width:22%;float:left;text-align:right;line-height:30px;margin-right:10px;">Attendant Name :</div>
                        <div style="width:45%;float:left;text-align:left;line-height:30px;"><input type="text" class="form-control lbl-field1" id="txtattname"  style="width:400px;" placeholder="Bed No Ex. 2XX2"/>     </div>
                    </div>
    </div>
                    <div class="row1" style="margin-bottom:10px;">

                    <div style="width:98%;float:left;">
                        <div style="width:22%;float:left;text-align:right;line-height:30px;margin-right:10px;">Delivery Location :</div>
                        <div style="width:45%;float:left;text-align:left;line-height:30px;"><input type="text" class="form-control lbl-field1" id="txtdelloc"  style="width:400px;" placeholder="Food Item Delivery Location"/> </div>
                        </div>
                    </div>
                    <div class="row1" style="margin-bottom:15px;">
                        <div style="width:45%;float:left;">
                        <div style="width:47%;float:left;text-align:right;line-height:30px;margin-right:12px;">Date of Entry :</div>
                        <div style="width:45%;float:left;text-align:left;line-height:30px;"><input type="text" id="txtdoe" readonly="true" class="form-control"  style="width:115px;" placeholder="DD/MM/YYYY"/> </div>
                    </div>
                    <div style="width:45%;float:left;padding-left:15px;">
                    <div style="width:45%;float:left;text-align:right;line-height:30px;margin-right:10px;">Date of Delivery :</div>
                    <div style="width:45%;float:left;text-align:left;line-height:30px;"><input type="text" id="txtdod" class="form-control" readonly="true" style="width:115px;" placeholder="DD/MM/YYYY"/> </div>
                    </div>
                    </div>
             
                               
             </div>
            </div>
                </div>
            <div class="Hospital-service" id="dvitemlist" style="display:none;">
                        <div class="row dv-sub-header">
                            <span style="padding-left: 10px; float: left;">Add Items : </span>
                            <div style="float: right; padding-right: 5px;">
                                <span id="A" class="filt-sec filt_service">A</span>
                                <span id="B" class="filt-sec filt_service">B</span>
                                <span id="C" class="filt-sec filt_service">C</span>
                                <span id="D" class="filt-sec filt_service">D</span>
                                <span id="E" class="filt-sec filt_service">E</span>
                                <span id="F" class="filt-sec filt_service">F</span>
                                <span id="G" class="filt-sec filt_service">G</span>
                                <span id="H" class="filt-sec filt_service">H</span>
                                <span id="I" class="filt-sec filt_service">I</span>
                                <span id="J" class="filt-sec filt_service">J</span>
                                <span id="K" class="filt-sec filt_service">K</span>
                                <span id="L" class="filt-sec filt_service">L</span>
                                <span id="M" class="filt-sec filt_service">M</span>
                                <span id="N" class="filt-sec filt_service">N</span>
                                <span id="O" class="filt-sec filt_service">O</span>
                                <span id="P" class="filt-sec filt_service">P</span>
                                <span id="Q" class="filt-sec filt_service">Q</span>
                                <span id="R" class="filt-sec filt_service">R</span>
                                <span id="S" class="filt-sec filt_service">S</span>
                                <span id="T" class="filt-sec filt_service">T</span>
                                <span id="U" class="filt-sec filt_service">U</span>
                                <span id="V" class="filt-sec filt_service">V</span>
                                <span id="W" class="filt-sec filt_service">W</span>
                                <span id="X" class="filt-sec filt_service">X</span>
                                <span id="Y" class="filt-sec filt_service">Y</span>
                                <span id="Z" class="filt-sec filt_service">Z</span>

                            </div>
                        </div>
                        <div id="dv_services" class="grid_property"></div>
                    </div>
            <div id="dvpreviewreceipt" style ="display:none; width:47%;float:left;border:1px solid #ccc;overflow:auto;margin:0px 0px 20px 20px ;padding:5px;background-color: #e6e6fa;">
                <div class="row1">
             <span class="box-header">Item Details:</span>
             </div>
                <%--<div  style="overflow:auto;border:1px solid #ccc;">
                                          <div style="width:49%;float:left;">
                                          <div class="row1" >
                                          <div style="width:49%;float:left;text-align:right;line-height:30px;">
                                              Select Item :
                                          </div>
                                          <div style="width:49%;float:left;">
                                          <select id="ddlfooditem"  class="input-with-feedback form-control" data-fieldtype="Select" data-fieldname="pos_type"  >
                                          <option value ="0">Select</option>
                                          </select>
                                          </div>
                                          </div>
                                          </div>
                                          <div style="width:29%;float:left;">
                                             <div class="row1">
                                          <div style="width:49%;float:left;text-align:right;line-height:30px;">
                                              QTY :
                                          </div>
                                          <div style="width:49%;float:left;">
                                          <select type="text" class="input-with-feedback form-control" data-fieldtype="Select" data-fieldname="pos_type" placeholder="" id="ddlqty">
                                          <option value ="0">Select</option>
                                          <option value ="1" selected="selected">01</option>
                                          <option value ="2">02</option>
                                          <option value ="3">03</option>
                                          <option value ="4">04</option>
                                          <option value ="5">05</option>
                                          <option value ="6">06</option>
                                          <option value ="7">07</option>
                                          <option value ="8">08</option>
                                          <option value ="9">09</option>
                                          <option value ="10">10</option>
                                          </select>
                                          </div>
                                          </div>
                                              
                                       

                                          </div>
                                          <div style="width:19%;float:left;">
                                              <div class="btn btn-primary" id="btnadditem">ADD</div>
                                          </div>
              </div>--%>
                <div class ="row1" id="dvitemlistheader" itemstring="" style="background-color:oldlace;border:1px solid #ccc;">
                    <div style="float:left;width:8%;">#.</div>
                    <div style="float:left;width:50%;">Item Name</div>
                    <div style="float:left;width:10%;">Rate</div>
                    <div style="float:left;width:10%;">Qty.</div>
                    <div style="float:left;width:10%;">Amt.</div>
                    <div style="float:left;width:8%;">X</div>
                </div>
                <div class ="row1" id="itemidetail"  >
                </div>
                <div class ="row1" id="itemfooter" style="background-color:oldlace;border:1px solid #ccc;" >
                <div class ="row1">
                 <div style="text-align:right;float:left;width:80%;">Sub Total :</div>
                 <div style="text-align:right;float:left;margin-left:5px;"><span id="spnsubtotalamt"></span></div>
                </div>
                <div class ="row1">
                 <div style="text-align:right;float:left;width:80%;">GST Details :</div>
                 <div style="text-align:right;float:left;margin-left:5px;"><span></span></div>
                </div>
                <div class ="row1">
                 <div style="text-align:right;float:left;width:80%;">CGST @ 9%:</div>
                 <div style="text-align:right;float:left;margin-left:5px;"><span id="spncgstdetails"></span></div>
                </div>
                <div class ="row1">
                 <div style="text-align:right;float:left;width:80%;"> SGST @ 9%:</div>
                 <div style="text-align:right;float:left;margin-left:5px;"><span id="spnsgstdetails"></span></div>
                </div>
                <div class ="row1">
                 <div style="text-align:right;float:left;width:80%;">Total Amt. :</div>
                 <div style="text-align:right;float:left;margin-left:5px;"><span id="spngtotal"></span></div>
                </div>
                </div>
                <div class ="row1">
                    <div class ="btn btn-primary" style="margin-top:10px;" id="btngenratebill" >Genrate Bill ( &#8377; <span id="spnbtngtotal"></span> )</div>
                </div></div>
            
        </div>
    </center>
    </div>
</asp:Content>
