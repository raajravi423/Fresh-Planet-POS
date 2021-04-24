<%@ Page Title="Fresh Planet Dashboard" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Fnb_Order.Admin.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css" >
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
    width: 100%;
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


    </style>
    <script type="text/javascript" >




        $(document).ready(function () {

            BindModule();

            $("#btnstart").on("click", function () {
                var selval = $("#ddlfnbactivitylist").val();
                if (selval != '0') {
                    window.location = selval;
                }
                else {
                    alert("Please Select Atleast One Activity.");
                }
            });
        });

        function BindModule() {
                $.ajax({
                    type: 'POST',
                    url: '/Admin/Dashboard.aspx/GetUserRole',
                    data: JSON.stringify({}),
                    dataType: 'json',
                    contentType: 'application/json;charset=utf-8',
                    async: false,
                    success: function (data) {
                        $("#ddlfnbactivitylist").empty();
                        $("#ddlfnbactivitylist").append("<option value ='Select'>Select</option>");
                        if (data.d == "FNBUSER")
                        { 
                            $("#ddlfnbactivitylist").append("<option value ='FnBAttendantOrder.aspx'>Genrate Order</option>");
                        }
                        else if (data.d == "BILLUSER")
                        {
                            $("#ddlfnbactivitylist").append("<option value ='BillingSlip.aspx'>Patient Summary</option>");
                        }
                        else if (data.d == "ADMIN")
                        {
                            $("#ddlfnbactivitylist").append("<option value ='FnBAttendantOrder.aspx'>Genrate Order</option><option value ='BillingSlip.aspx'>Patient Summary</option>");

                        }
                    }
                });
          

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
       <div id="dvITTransaction" class="main-content">
        <div class="row dv-header">
            <div class="main-header-text">F&B Transaction</div>
        </div>

        <div class="main-body-content">
            <div style="margin: 100px" class="text-center">
                <p>Select Type of Transaction</p>
                <p style="margin: auto; max-width: 300px; margin-bottom: 15px;" class="select-type">
              
                <select type="text" class="input-with-feedback form-control" data-fieldtype="Select" data-fieldname="pos_type" placeholder="" id="ddlfnbactivitylist">
                <option value ="0">Select</option>
             
                </select>
                </p>
                <p>
                <div class="btn btn-primary" id="btnstart">Start</div>
                </p>
            </div>
        </div>
    </div>
</asp:Content>
