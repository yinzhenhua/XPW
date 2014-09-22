<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EquipmentEnergyEfficiencyPage.aspx.cs" Inherits="XPW.EquipmentEnergyEfficiencyPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <link type="text/css" rel="stylesheet" href="Content/GridView.css" />
    <div class="moduleDIV">
        <h2>Dept. Electricity Consumption Statistics
        </h2>
        <table>
            <tr>
                <td colspan="2">
                    <div style="overflow: auto; height: 620px; width: 1120px; margin-left: 3px; margin-right: 3px" id="dvBody" runat="server">
                        <asp:Chart ID="ecpChart1" runat="server" Width="1118px"
                            Palette="BrightPastel" BackColor="#F3DFC1" BorderDashStyle="Solid" BackGradientStyle="TopBottom" BorderWidth="1" BorderColor="181, 64, 1">
                            <Titles>
                                <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" Alignment="TopLeft" ShadowOffset="3" Name="ecpTitle" ForeColor="26, 59, 105"></asp:Title>
                            </Titles>
                            <BorderSkin SkinStyle="Emboss"></BorderSkin>
                            <Series>
                                <asp:Series Name="ecpSeries" BorderColor="180, 26, 59, 105" Color="#9bbb59">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ecpChartArea" BorderColor="64, 64, 64, 64" BackSecondaryColor="White" BackColor="OldLace" ShadowColor="Transparent" BackGradientStyle="TopBottom"></asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                        <asp:Chart ID="ecpChart2" runat="server" Width="1118px"
                            Palette="BrightPastel" BackColor="#F3DFC1" BorderDashStyle="Solid" BackGradientStyle="TopBottom" BorderWidth="1" BorderColor="181, 64, 1">
                            <Titles>
                                <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" Alignment="TopLeft" ShadowOffset="3" Name="ecpTitle" ForeColor="26, 59, 105"></asp:Title>
                            </Titles>
                            <BorderSkin SkinStyle="Emboss"></BorderSkin>
                            <Series>
                                <asp:Series Name="ecpSeries" BorderColor="180, 26, 59, 105" Color="#9bbb59">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ecpChartArea" BorderColor="64, 64, 64, 64" BackSecondaryColor="White" BackColor="OldLace" ShadowColor="Transparent" BackGradientStyle="TopBottom"></asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </div>
                </td>
            </tr>
        </table>
    </div>

</asp:Content>
