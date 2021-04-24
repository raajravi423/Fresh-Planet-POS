<%@ Page Title="Create Order" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="CreateOrder.aspx.cs" Inherits="Fnb_Order.Admin.CreateOrder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<%--    <style type="text/css" >
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
           // BindModule();
            $("#btnstart").on("click", function () {
                var selval = $("#ddlfnbactivitylist").val();
                if (selval != '0') {
                    window.location = selval;
                }
                else {
                    alert("Please Select Atleast One Activity.");
                }
            });

            $('.datepicker').datepicker(
                {
                    minDate:0,
                    dateFormat: 'yy-mm-dd',
                    changeMonth: true,
                    changeYear: true,
                    yearRange: '2020:2022'
                }); 
        });
        
    </script> --%>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Body" runat="server">
       <div id="dvITTransaction" class="main-content">
        <div class="row dv-header">
            <div class="main-header-text">Create Order</div>
        </div>
        <div class="main-body-content">

            <table class="auto-style1">
                <tr>
                    <td style="width:50%;">
                        <table style="width:50%;">
                            <tr>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>


                    </td>
                    <td style="width:50%;">
                        

                    </td>
                </tr>
            </table>

    </div>
       </div>
</asp:Content>