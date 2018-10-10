﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmBuildMap.aspx.cs" Inherits="IEF_Visualization.frmBuildMap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Map Maker</title>

    <!-- css -->
    <link href="css/jquery-ui.css" rel="stylesheet" />
    
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/footer-distributed-with-address-and-phones.css" rel="stylesheet" />
    <link href="css/body.css" rel="stylesheet" />


    <!-- css -->
    <!-- JavaScriptLibrary -->

    <script src="scripts/lib/d3.min.js"></script>
    <script src="scripts/lib/d3.v2.js"></script>
    <script src="scripts/lib/canvg.js"></script>
    <script src="scripts/lib/rgbcolor.js"></script>
    <script src="scripts/lib/Blob.js"></script>
    <script src="scripts/lib/FileSaver.js"></script>
    <script src="scripts/lib/topojson.min.js"></script>
    <!-- JavaScriptLibrary -->
    <!-- Customscripts -->

    <script src="scripts/custom_map.js"></script>
    <script src="scripts/fileUploader.js"></script>
    <script src="scripts/fileExporter.js"></script>

    <!-- CustomJavaScript -->

    <style type="text/css">
        #map {
            fill: #E5F5F9;
            stroke: #2CA25F;
            stroke-width: 1px;
        }

        #axes {
            stroke: #BDBDBD;
            stroke-width: 1px;
        }
    </style>

     <style>
          
            path { stroke-width: .5px; fill: white; }
            path:hover { fill: #666; }

            .tooltip {
                color: #222; 
                background: #fff; 
                padding: .5em; 
                text-shadow: #f5f5f5 0 1px 0;
                border-radius: 2px; 
                box-shadow: 0px 0px 2px 0px #a6a6a6; 
                opacity: 0.9; 
                position: absolute;
            }
            .hidden {
                display: none;
            }
        </style>

    <style>


   .countryList{
        border: 3px solid #85859d;
        font-family: sans-serif;
        font-size: 15px;
        margin: 3px;
        padding: 2px;
        width: 60%;

        }

    </style>


  <style>

        .col-md-8 {
            text-align:left;

        }

        .col-md-12 {
            padding-left:0px;
            /*background-color:#229922;*/

        }

        .col-md-4 {
            padding-left:0px;
            /*background-color:#229922;*/

        }
         .col-md-10 {
            text-align: right;
            padding-bottom: 0px;

        }

.col-md-2 {
    float: left;
    padding: 0;
    background-color:none;
    padding-bottom: 0px;
}
.col-md-2 p a, p a:hover {
    color: darkgreen;
    font-weight:bold;
    font-size:22px;
    text-decoration: none;
}
.col-md-2 p span {
    color: lightgreen;
}

        .table {
    margin-bottom: 1px;
}

        .ui-tabs .ui-tabs-panel {
    border-width: 0;
    display: block;
    padding: .2em .2em;
}
        .ui-tabs .ui-tabs-nav {
    margin: 0;
}

        .btn{
            margin-right: 7px;
    margin-top: 8px;
        }
        .table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
    border-top: 1px solid #ddd;
    line-height: 1.42857;
    padding: 5px;
    vertical-align: inherit;
}
  
    </style>

</head>
<body>
    <form id="form1" runat="server" onsubmit="mapMaker(); return false;">
    <div class="jumbotron">
          <div class="container-fluid">
    
                    <div class="col-md-2">
                        <img src="resources/IEF_Logo.png" style="padding-left:10px;" width="150px" height="150px" />
                    </div>
                    <div class="col-md-8" style="padding-left:30px;">
                        <h2>Industrial Ecology Freiburg</h2>
                        <p style="font-size:16px;">Research group at the Faculty of Environment and Natural Resources</p>
                    </div>
                    <div class="col-md-2">
                        <img src="resources/uni_freiburg.png" width="120px" height="150px"/>
                    </div>
                
  </div>
</div>
     
<nav class="navbar navbar-default navbar-custom navbar">
  <div class="container-fluid">   
        <div class="navbar-header">
      <a class="navbar-brand" href="#">Circular Sankey</a>
    </div>

      <ul class="nav navbar-nav navbar-right">
          
                    <li><a href="frmHome.aspx">Login</a></li>
                        <li><a href="frmCircularSankey.aspx">Sankey Diagram</a></li>
                        <li class="active"><a href="frmBuildMap.aspx">Map Maker</a></li>
                        <li><a href="frmBuildChart.aspx">Pie Chart</a></li>
                        <li><a href="frmUserProfile.aspx">Your History</a></li>
                        <li><a href="frmUserGuide.aspx">User Guide</a></li>
                        <li><a href="http://www.industrialecology.uni-freiburg.de" target="_blank">Home</a></li>
          <li><asp:Button ID="btnLogOut" runat="server" class="btn btn-info" Text="Log Out" OnClick="btnLoggOut_Click" /></li>

                 
      </ul>
      
  </div>
</nav>

<div class="container-fluid" >
           <h3>Under Development</h3>
            <div id="content-inner" style="visibility:hidden">

                <div id= "content-inner-sankey-row1">
                    <div id= "content-inner-sankey-row1col1"> 
                        Project Name:<asp:TextBox ID="txtproject_name" runat="server" CssClass="textbox"></asp:TextBox>
&nbsp;<label><br />
                         <label>Please select file</label>
                          <input id="fileInput" type="file" />
                                        <input type="button" id="upload" value="Upload" class="button" onclick="chooseFunction();" />
                        <br />
                                            <label><strong>Background Color:</strong></label> 
                        <input type="color" id="background_color" size="7" maxlength="7" value="#FFFFFF" onchange="mapMaker();"/>
                                            <br />
                                            <label><strong>Flow Opacity:</strong></label>
                                            <span class="no_wrap"><span class="smalllabel">0.0</span>
                       <input id="default_flow_opacity" type="range" min="0" max="1" step="0.1" value="0.5" onchange="mapMaker();" class="slider"/><span class="smalllabel">1.0</span></span>

                </div>
                    <div id= "content-inner-sankey-row1col2">
                        <h2 class="ui_head">
                                            Value:
                                        </h2>
    <textarea id="input_country_list" runat="server" rows="12" cols="120" onchange="mapMaker();">
Type a list of Country data following this format, an example given for you:

[COUNTRY_ID] [COUNTRY_NAME] [VALUE] [COLOR_CODE]

[57] [Germany] [7000000] [#ff7f0e]
[16] [Austria] [2000000] [#1f77b4]
[72] [France] [7000000] [#ffbb78]
[39] [Switzerland] [7000000] [#aec7e8]
[108] [Italy] [7000000] [#2ca02c]
[77] [United Kingdom] [7000000] [#1f77b4]
                                        </textarea>
                </div>
                    <div id= "content-inner-sankey-row1col3" style="display: none;">
  <h2 class="ui_head">
                                            
                                        </h2>

                         Select Country
                                        <select id="countryList" class="countryList">
                                           
                                        </select>
                                        <input id="addCountry" type="submit" value="Add" class="button" />

                                    </div>
                     <div class="clr"></div>
                </div>
                     
              
               
                <div id= "content-inner-sankey-row2">
                       <div id= "content-inner-sankey-row2Col1">
                      <input id="preview_graph" type="submit" value="Preview" class="button" />
                    &nbsp; &nbsp;
                    &nbsp; &nbsp;
                           <asp:Button ID="btnSaveData" runat="server" Text="Save Data" class="button" OnClick="btnSaveData_Click" />
                    &nbsp; &nbsp;
                    &nbsp; &nbsp;
                    <button id="generate" class="button" onclick="fileExporter();">Save as SVG</button>
                     <div class="clr"></div>
                </div>
                </div>

                <div id= "content-inner-sankey-row3">
                            <label><strong>Diagram Width:</strong></label>
                            <span class="no_wrap">
                              <input class="wholenumber" id="canvas_width" size="5" maxlength="6" value="1100" onchange="mapMaker();"/> px</span>
                            <label class="spaced_label"><strong>Height:</strong></label>
                            <span class="no_wrap">
                                <input type="text" class="wholenumber" id="canvas_height" size="5" maxlength="6" value="800" onchange="mapMaker();"/> px</span>
               
                     &nbsp; &nbsp;
                            &nbsp; &nbsp;
                    <label><strong>Remarks:</strong></label>
                    <asp:TextBox id="txtRemarks" runat="server"></asp:TextBox> 

                    <div class="clr"></div>
                     </div>
               
             

                  <div id= "content-inner-sankey-row4">
                      <div id="map"></div>
                    <div id="tooltip"></div>
                    <p id="chart">
                       
                        
                        <svg id="target_svg" height="1100" width="800" xmlns="http://www.w3.org/2000/svg" version="1.1"></svg>
                    </p>
                    <canvas id="png_preview" height="1100" width="800" style="background: #FFFFFF; display:none;"></canvas>

                      <div class="clr"></div>
                </div>



        </div>
       </div>
     
          <br /><br /><br />
		<footer class="footer-distributed">

			<div class="footer-left">

				<p class="footer-links">
                    <a href="http://www.blog.industrialecology.uni-freiburg.de">Blog</a>
                    .
                    <a href="http://www.blog.industrialecology.uni-freiburg.de">Research</a>
                    .
                    <a href="http://www.database.industrialecology.uni-freiburg.de">Database</a>
                    .
           <a href="http://www.visualisation.industrialecology.uni-freiburg.de">Visualisation</a>
                    .
                    <a href="http://www.teaching.industrialecology.uni-freiburg.de">Teaching</a>
                    .
            <a href="http://www.internal.industrialecology.uni-freiburg.de">Internal</a>

				</p>
			
			</div>

			<div class="footer-center">
				<div>

                    <h3>Industrial Ecology <span>Freiburg</span></h3>
					<p>  &copy; 2017 Stefan Pauliuk &amp; Mahadi Hasan<br>
                        Sustainable Energy and Material Flow Management (Industrial Ecology) <br>
                        Faculty of Environment and Natural Resources <br>
                       
					       Tennenbacher Straße 4 <br>
                         D-79106 Freiburg <br>
                        Germany <br>
                        email: in4mation@indecol-freiburg.de <br>
                        </p>
				</div>

			</div>

			

		</footer>
         <script>
             mapMaker(); // render on page load
    </script>
    </form>
</body>
</html>