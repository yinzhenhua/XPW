<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EquipmentEnergyEfficiencyPage.aspx.cs" Inherits="XPW.EquipmentEnergyEfficiencyPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <link type="text/css" rel="stylesheet" href="Content/GridView.css" />
    <div class="moduleDIV">
        <h2>
            <asp:Label runat="server" ID="lblTitle"></asp:Label>
        </h2>
        <table>
            <tr>
                <td colspan="2">
                    <div style="overflow: auto; height: 255px; width: 1118px" id="dvBody">
                        <asp:GridView runat="server" ID="gvDept" AutoGenerateColumns="False"
                            Width="1300px"
                            CssClass="mGrid"
                            AlternatingRowStyle-CssClass="alt"
                            OnRowCreated="gvDept_RowCreated" OnRowDataBound="gvDept_RowDataBound">
                            <Columns>
                                <asp:BoundField DataField="Name" HeaderText="ITEM">
                                    <HeaderStyle Width="17.5%" />
                                    <ItemStyle Width="17.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="PreviousYear" HeaderText="Previous Year">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="YTD" HeaderText="YTD">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Q1" HeaderText="Q1">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Q2" HeaderText="Q2">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Q3" HeaderText="Q3">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Q4" HeaderText="Q4">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Month1" HeaderText="">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Month2" HeaderText="">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Month3" HeaderText="">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Week1" HeaderText="Week-1">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Week2" HeaderText="Week-2">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Week3" HeaderText="Week-3">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Week4" HeaderText="Week-4">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Week5" HeaderText="Week-5">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Week6" HeaderText="Week-6">
                                    <HeaderStyle Width="5.5%" />
                                    <ItemStyle Width="5.5%" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Chart ID="ecpChart" runat="server" Width="1118px"
                        Palette="BrightPastel" BackColor="#F3DFC1" BorderDashStyle="Solid" BackGradientStyle="TopBottom" BorderWidth="1" BorderColor="181, 64, 1">
                        <Titles>
                            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" Alignment="TopLeft" ShadowOffset="3" Name="ecpTitle" ForeColor="26, 59, 105"></asp:Title>
                        </Titles>
                        <BorderSkin SkinStyle="Emboss"></BorderSkin>
                        <Legends>
                            <asp:Legend TitleFont="Microsoft Sans Serif, 8pt, style=Bold" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold" IsTextAutoFit="False" Enabled="True"
                                Alignment="Center" Docking="Bottom">
                            </asp:Legend>
                            <asp:Legend TitleFont="Microsoft Sans Serif, 8pt, style=Bold" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold" IsTextAutoFit="False" Enabled="True"
                                Alignment="Center" Docking="Bottom">
                            </asp:Legend>
                        </Legends>
                        <Series>
                            <asp:Series Name="Efficiency" BorderColor="180, 26, 59, 105" Color="#4f81bd">
                            </asp:Series>
                            <asp:Series Name="Baseline" BorderColor="180, 26, 59, 105" Color="#00b050">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ecpChartArea" BorderColor="64, 64, 64, 64" BackSecondaryColor="White" BackColor="OldLace" ShadowColor="Transparent" BackGradientStyle="TopBottom"></asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                </td>
            </tr>

        </table>
    </div>

</asp:Content>
