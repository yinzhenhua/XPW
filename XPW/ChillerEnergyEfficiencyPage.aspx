﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChillerEnergyEfficiencyPage.aspx.cs" Inherits="XPW.ChillerEnergyEfficiencyPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <link type="text/css" rel="stylesheet" href="Content/GridView.css" />
    <div>
        <table>
            <tr>
                <td colspan="2">Real Time Chiller's Energy Efficiency
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:GridView runat="server" ID="gvDept" AutoGenerateColumns="False" Width="950"
                        CssClass="mGrid"
                        PagerStyle-CssClass="pgr"
                        AlternatingRowStyle-CssClass="alt">
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="ITEM">
                                <HeaderStyle Width="70px" Wrap="false" />
                                <ItemStyle Width="70px" Wrap="false" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Chiller1" HeaderText="Chiller 1#">
                                <HeaderStyle Width="70px" Wrap="false" />
                                <ItemStyle Width="70px" Wrap="false" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Chiller2" HeaderText="Chiller 2#">
                                <HeaderStyle Width="70px" Wrap="false" />
                                <ItemStyle Width="70px" Wrap="false" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Chiller3" HeaderText="Chiller 3#">
                                <HeaderStyle Width="70px" Wrap="false" />
                                <ItemStyle Width="70px" Wrap="false" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Chiller4" HeaderText="Chiller 4#">
                                <HeaderStyle Width="70px" Wrap="false" />
                                <ItemStyle Width="70px" Wrap="false" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Chiller5" HeaderText="Chiller 5#">
                                <HeaderStyle Width="70px" Wrap="false" />
                                <ItemStyle Width="70px" Wrap="false" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Chart ID="ecpChart" runat="server" Width="950"
                        Palette="BrightPastel" BackColor="#F3DFC1" BorderDashStyle="Solid" BackGradientStyle="TopBottom" BorderWidth="1" BorderColor="181, 64, 1">
                        <Titles>
                            <asp:Title ShadowColor="32, 0, 0, 0" Font="Trebuchet MS, 14.25pt, style=Bold" Alignment="TopLeft" ShadowOffset="3" Name="ecpTitle" ForeColor="26, 59, 105" Text="Chiller's Energy Efficiency"></asp:Title>
                        </Titles>
                        <Legends>
                            <asp:Legend TitleFont="Microsoft Sans Serif, 8pt, style=Bold" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold" IsTextAutoFit="False" Enabled="True"
                                Alignment="Center" Docking="Bottom">
                            </asp:Legend>
                            <asp:Legend TitleFont="Microsoft Sans Serif, 8pt, style=Bold" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold" IsTextAutoFit="False" Enabled="True"
                                Alignment="Center" Docking="Bottom">
                            </asp:Legend>
                        </Legends>
                        <BorderSkin SkinStyle="Emboss"></BorderSkin>
                        <Series>
                            <asp:Series Name="Actual VS Nominal COP" BorderColor="180, 26, 59, 105" Color="Red">
                            </asp:Series>
                            <asp:Series Name="BaseLine" BorderColor="180, 26, 59, 105"
                                Color="Red">
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
