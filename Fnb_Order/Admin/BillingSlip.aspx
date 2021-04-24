<%@ Page Title="Billing Summary" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="BillingSlip.aspx.cs" Inherits="Fnb_Order.Admin.BillingSlip" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .main-content {
            border: 1px solid #c7c7c7;
            border-radius: 4px;
            box-shadow: 2px 2px 7px #ccc;
            height: auto;
            margin-top: 15px;
            min-height: 450px;
            overflow: auto;
            padding-bottom: 20px;
            width: 100%;
        }

        .dv-header {
            background-color: #f9f9f9;
            font-size: 22px;
            line-height: 50px;
        }

        .row {
            border-bottom: 1px solid #c7c7c7;
        }


        .main-header-text {
            text-align: center;
            width: 100%;
        }

        .text-center {
            text-align: center;
        }


        .form-control {
            background-color: #fff;
            background-image: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            color: #555;
            display: block;
            font-size: 14px;
            line-height: 1.42857;
            padding: 6px 12px;
        }


        .btn {
            -moz-user-select: none;
            background-image: none;
            border: 1px solid transparent;
            border-radius: 4px;
            cursor: pointer;
            display: inline-block;
            font-size: 14px;
            font-weight: normal;
            line-height: 1.42857;
            margin-bottom: 0;
            padding: 6px 12px;
            text-align: center;
            vertical-align: middle;
            white-space: nowrap;
        }

        .btn-primary {
            background-color: #2980b9;
            border-color: #2472a4;
            color: #fff;
        }

            .btn-primary:hover {
                background-color: #20638f;
            }

        .form-lbl {
            float: left;
            text-align: right;
            line-height: 30px;
            width: 40%;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnSearch").on("click", function () {
                if (CheckSession() == true) {

                //    if ($("#txtamount").attr("validsts") == true && $("#txtamount").attr("validsts") == true) {
                        if ($("#txtbedno").val() == "" || $("#txtbedno").val() == " ") {
                            $("#txtbedno").css("border", "1px solid red");
                            alert("IP Number is Required");
                        }
                        else {
                            GenrateReceiptNumber()
                            
                            $("#txtbedno").css("border", "1px solid #ccc");
                            $("#iframe").attr("src", "CReport/Print.aspx?Flg=S2&IPID=" + $("#txtbedno").val() + "^" + $("#ddlpaymentmode").val() + "");
                        }
                //    }
                }
                else {
                    window.location = "../Login.aspx";
                }

            });

            
            $('#txtbedno').live("keyup", function () {
                //alert($(this).val());
                $.ajax
               ({
                   type: 'POST',
                   url: '/Admin/BillingSlip.aspx/GetTotalAmt',
                   data: JSON.stringify({ IPID: $(this).val()}),
                   dataType: 'json',
                   contentType: 'application/json;charset=utf-8',
                   async: false,
                   success: function (data) {
                       if (data.d.length > 0 )
                       {
                           $("#txtamount").val(data.d);
                           $("#txtamount").attr("totamt",data.d);
                       }
                       else
                       {
                           $("#txtamount").val("");
                           $("#txtamount").attr("totamt", "");
                       }
                   }
               });

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

            $("#txtamount").live("keyup", function (event) {
                var float = /^\s*(\+|-)?((\d+(\.\d+)?)|(\.\d+))\s*$/;
                var numbersOnly = /^\d+$/;                  
              
                if (numbersOnly.test($("#txtamount").val()) || float.test($("#txtamount").val())) {
                    $("#txtamount").attr("validsts", "true");
                    $("#txtamount").css("border", "1px solid #ccc");                  
                }
                else {
                    $("#txtamount").attr("validsts", "false");
                    $("#txtamount").css("border", "1px solid red");
                }
            });

            $("#txtDiscountAmt").live("keyup", function (event) {

                var float = /^\s*(\+|-)?((\d+(\.\d+)?)|(\.\d+))\s*$/;
                var numbersOnly = /^\d+$/;
                var totamt = parseFloat($("#txtamount").attr("totamt")).toFixed(2);
                var amt = parseFloat($("#txtamount").val()).toFixed(2);
                var disc = parseFloat($("#txtDiscountAmt").val()).toFixed(2);

                if ($("#txtamount").val() != "" || $("#txtamount").val() != " ") {
                    if (parseFloat(disc) < parseFloat(totamt)) {
                        $("#txtamount").val(totamt - disc);
                    }
                    else {
                        alert("Discount Amount Should be Less Then \n or Equal to Total Amount. ");
                        $("#txtDiscountAmt").val('0');
                    }
                }
                else {
                    $("#txtDiscountAmt").val(totamt);
                }


                if (numbersOnly.test($("#txtDiscountAmt").val()) || float.test($("#txtDiscountAmt").val())) {
                    $("#txtDiscountAmt").attr("validsts", "true");
                    $("#txtDiscountAmt").css("border", "1px solid #ccc");
                }
                else {
                    $("#txtDiscountAmt").attr("validsts", "false");
                    $("#txtDiscountAmt").css("border", "1px solid red");
                }


            });



            $("#ddlpaymentmode").live("change", function () {
                var text = $(this).val();
                if (CheckSession() == true) {
                    if (text == "Cash")
                    {
                        $("#dvcarddetails").hide('10000');
                        $("#dvchequedetails").hide('10000');
                    }
                    else if (text == "Card")
                    {
                        $("#dvcarddetails").show('10000');
                        $("#dvchequedetails").hide('10000');

                    }
                    else if (text == "Cheque") {
                        $("#dvcarddetails").hide('10000');
                        $("#dvchequedetails").show('10000');
                    }
                }
                else {
                    window.location = "../Login.aspx";
                }

            })

        });

        function CheckSession() {
            var retval;
            $.ajax
                ({
                    type: 'POST',
                    url: '/Admin/BillingSlip.aspx/CheckSession',
                    data: JSON.stringify({}),
                    dataType: 'json',
                    contentType: 'application/json;charset=utf-8',
                    async: false,
                    success: function (data) {
                        retval = data.d;
                    }
                });
            return retval;
        }

        function GenrateReceiptNumber() {
            $.ajax({
                type:'POST',
                url: '/Admin/BillingSlip.aspx/GenrateReceiptNumber',
                data: JSON.stringify({
                    IPNO: $("#txtbedno").val(), PaymentMode: $("#ddlpaymentmode option:selected").text(), Amount: $("#txtamount").val(), ChequeNo: $("#txtchequeno").val(), CBankName: $("#txtBankName").val(), CBranchName: $("#txtbranchname").val(), CMICRCode: $("#txtmicrcode").val(), ChequeDate: $("#txtchequedate").val(), CaCardType: $("#ddlcardtype").val(), CaCardNumber: $("#txtcarno").val(), CaCardHolder: $("#txtcardholername").val(), CaIssuingAuthority: $("#txtIAName").val(), CaIssuBranch: $("#txtIBName").val(), CaAuthCode: $("#txtAuthcode").val(), CaValidFrom: $("#txtvalidfrom").val(), CaValidUpto: $("#txtvalidupto").val(), DiscountAmt: $("#txtDiscountAmt").val(), IsSattlement: $('#chkissattlement:checked').length
                }),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                async: false,
                success: function (data) {
                    if (data.d.length > 0) {
                        return data.d;
                    }
                    else {
                        return '-';
                    }
                }
            });
        }

      
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
    <div id="dvITTransaction" class="main-content">
        <div class="row dv-header">
            <div class="main-header-text">Patient Summary</div>
        </div>
        <div class="main-body-content">
            <div class="row1"><span id="spnmsg"></span></div>
            <div id="dvpatientdetails" style="width: 100%; float: left; overflow: auto;">
                <div style="width: 100%; overflow: auto; height: auto;">
                    <div class="row1">
                    <div class="row1">
                    </div>
                    <center>
                    <div  style="width:880px;overflow:auto;margin-bottom:15px;margin-top:50px;">                
                    <div style="float:left;width:33%;">
                    <div class="form-lbl">IP Number :</div>
                    <div style="float:left;text-align:left;margin-left:20px;"><input type="text" id="txtbedno" class="form-control" style="width:120px;"  placeholder="IPID Ex. DELIPXXXXX" maxlength="12"/> </div>
                    </div>
                    <div style="float:left;width:33%;">
                    <div class="form-lbl">Payment Mode :</div>
                    <div style="float:left;text-align:left;margin-left:20px;"><select class="input-with-feedback form-control" style="width:150px;" data-fieldtype="Select" data-fieldname="pos_type"   id="ddlpaymentmode">
                    <option value ="Cash">Cash</option>
                    <option value ="Cheque">Cheque</option>
                    <option value ="Card">Card</option>
                    </select></div>
                    </div>
                    <div style="float:left;width:33%;">
                     <div class="form-lbl">Amount :</div>
                     <div style="float:left;text-align:left;margin-left:20px;"><input type="text" totamt="" validsts ="" id="txtamount" class="form-control" style="width:120px;"   placeholder="Amount" maxlength="12"/> </div>                    
                     </div>
                     
                    </div>
                    <%--Cheque Details form--%>
                    <div id="dvchequedetails" style="display:none;"> 
                    <div style="width:880px;overflow:auto;margin-bottom:15px;">                
                    <div style="float:left;width:33%;">
                    <div class="form-lbl">Cheque No :</div>
                    <div style="float:left;text-align:left;margin-left:20px;"><input type="text" id="txtchequeno" class="form-control" style="width:120px;"  placeholder="Cheque No" maxlength="12"/> </div>
                    </div>
                    <div style="float:left;width:33%;">
                    <div class="form-lbl">Bank Name :</div>
                    <div style="float:left;text-align:left;margin-left:20px;">
                    <input type="text" id="txtBankName" class="form-control" style="width:120px;"  placeholder="Bank Name" />
                    </div>
                    </div>
                    <div style="float:left;width:33%;">
                     <div class="form-lbl">Branch Name :</div>
                     <div style="float:left;text-align:left;margin-left:20px;"><input type="text" id="txtbranchname" class="form-control" style="width:120px;"   placeholder="Branch Name" /> </div>                    
                     </div>
                     
                    </div>
                    <div style="width:880px;overflow:auto;margin-bottom:15px;">                
                    <div style="float:left;width:33%;">
                    <div class="form-lbl">MICR Code :</div>
                    <div style="float:left;text-align:left;margin-left:20px;"><input type="text" id="txtmicrcode" class="form-control" style="width:120px;"  placeholder="MICR Code" /> </div>
                    </div>
                    <div style="float:left;width:33%;">
                    <div class="form-lbl">Cheque Date :</div>
                    <div style="float:left;text-align:left;margin-left:20px;"><input type="text" id="txtchequedate" class="form-control" style="width:120px;"  placeholder="DD/MM/YYYY" /></div>
                    </div>                    
                    </div>
                    </div>
                    <%--Card Details form--%>
                    <div id="dvcarddetails" style="display:none;"> 
                    <div style="width:880px;overflow:auto;margin-bottom:15px;">                
                    <div style="float:left;width:33%;">
                    <div class="form-lbl">Card Type :</div>
                    <div style="float:left;text-align:left;margin-left:20px;"><select class="input-with-feedback form-control" style="width:150px;" data-fieldtype="Select" data-fieldname="pos_type"  id="ddlcardtype">
                      <option value ="NONE">Select</option>
                        <option value ="Credit">Credit</option>
                    <option value ="Debit">Debit</option>
                    </select></div>
                    </div>
                    <div style="float:left;width:33%;">
                    <div class="form-lbl">Card Number :</div>
                    <div style="float:left;text-align:left;margin-left:20px;"><input type="text" id="txtcarno" class="form-control" style="width:120px;"  placeholder="Card Number" maxlength="16"/></div>
                    </div>
                    <div style="float:left;width:33%;">
                    <div class="form-lbl">Card Holder :</div>
                    <div style="float:left;text-align:left;margin-left:20px;"><input type="text" id="txtcardholername" class="form-control" style="width:120px;"   placeholder="Card Holder Name" /></div>                    
                    </div>                     
                    </div>
                    <div style="width:880px;overflow:auto;margin-bottom:15px;">                
                    <div style="float:left;width:33%;">
                    <div class="form-lbl">Issuing Authority Name :</div>
                    <div style="float:left;text-align:left;margin-left:20px;"><input type="text" id="txtIAName" class="form-control" style="width:120px;"  placeholder="Authority Name" /> </div>
                    </div>
                    <div style="float:left;width:33%;">
                    <div class="form-lbl">Issuing Branch Name :</div>
                    <div style="float:left;text-align:left;margin-left:20px;"><input type="text" id="txtIBName" class="form-control" style="width:120px;"  placeholder="Branch Name" /></div>
                    </div>
                     <div style="float:left;width:33%;">
                     <div class="form-lbl">APPR / Auth Code :</div>
                     <div style="float:left;text-align:left;margin-left:20px;"><input type="text" id="txtAuthcode" class="form-control" style="width:120px;"   placeholder="Auth Code" /> </div>                    
                     </div>
                     
                    </div>
                    <div style="width:880px;overflow:auto;margin-bottom:15px;">                
                    <div style="float:left;width:33%;">
                    <div class="form-lbl">Valid From :</div>
                    <div style="float:left;text-align:left;margin-left:20px;"><input type="text" id="txtvalidfrom" class="form-control" style="width:120px;"  placeholder="MM/YY" maxlength="5"/> </div>
                    </div>
                    <div style="float:left;width:33%;">
                    <div class="form-lbl"> Valid Upto :</div>
                    <div style="float:left;text-align:left;margin-left:20px;"><input type="text" id="txtvalidupto" class="form-control" style="width:120px;"  placeholder="MM/YY" maxlength="5"/></div>
                    </div>
                     <%--<div style="float:left;width:33%;">
                     <div style="float:left;text-align:right;margin-left:20px;line-height:30px;">APPR / Auth Code :</div>
                     <div style="float:left;text-align:left;margin-left:20px;"><input type="text" id="txtamount" class="form-control" style="width:120px;"   placeholder="Amount" maxlength="12"/> </div>                    
                     </div>
                     --%>
                    </div>
                    </div> 
                    <div style="width:880px;overflow:auto;margin-bottom:15px;">                
                    <div style="float:left;width:33%;">
                    <div class="form-lbl">Add Discount :</div>
                    <div style="float:left;text-align:left;margin-left:20px;"><input type="text" validsts="" id="txtDiscountAmt" class="form-control" style="width:120px;"  placeholder="Discount in Rs" maxlength="5" value="0"/> </div>
                    </div>
                    <div style="float:left;width:50%;">
                    <div style="float:left;text-align:left;margin-left:20px;margin-top:7px;"><input style="line-height:30px;"  type="checkbox" id="chkissattlement" class="form-control"  /> </div>
                    <div class="form-lbl" style="width:65%;">Are You Want to do Complete Sattlement. ?</div>
                    </div>
                    <div style="float:left;width:12%;">
                    <div style="text-align:center;"><img src="../Images/printreceipt.png" id="btnSearch" alt="Search" title="Print Receipt" style="cursor:pointer;width:30px;height:30px" /> </div>
                    </div>
                    </div>
                    </center>

                    </div>
                </div>

            </div>

            <center><div id="myframe" style="width:70%;z-index:-200">
            <iframe id="iframe" src="" width="100%" height="300px" style="z-index:-200" >
            </iframe>
            </div>
            </center>


        </div>
    </div>

</asp:Content>
