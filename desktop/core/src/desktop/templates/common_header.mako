## Licensed to Cloudera, Inc. under one
## or more contributor license agreements.  See the NOTICE file
## distributed with this work for additional information
## regarding copyright ownership.  Cloudera, Inc. licenses this file
## to you under the Apache License, Version 2.0 (the
## "License"); you may not use this file except in compliance
## with the License.  You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
<%!
from django.utils.translation import ugettext as _

from desktop import conf
from desktop.conf import USE_NEW_EDITOR
from desktop.lib.i18n import smart_unicode

from metadata.conf import has_optimizer, OPTIMIZER

home_url = url('desktop.views.home')
if USE_NEW_EDITOR.get():
  home_url = url('desktop.views.home2')
%>

<%namespace name="koComponents" file="/ko_components.mako" />
<%namespace name="hueIcons" file="/hue_icons.mako" />
<%namespace name="commonHeaderFooterComponents" file="/common_header_footer_components.mako" />

<!DOCTYPE html>
<%def name="is_selected(selected)">
  %if selected:
    class="active"
  %endif
</%def>
<%def name="get_nice_name(app, section)">
  % if app and section == app.display_name:
    - ${app.nice_name}
  % endif
</%def>
<%def name="get_title(title)">
  % if title:
    - ${smart_unicode(title)}
  % endif
</%def>
<html lang="en">
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta charset="utf-8">
  <title>Hue ${get_nice_name(current_app, section)} ${get_title(title)}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" type="image/x-icon" href="${ static('desktop/art/favicon.ico') }" />
  <meta name="description" content="">
  <meta name="author" content="">

  <link href="${ static('desktop/ext/css/cui/cui.css') }" rel="stylesheet">
  <link href="${ static('desktop/ext/css/cui/bootstrap2.css') }" rel="stylesheet">
  <link href="${ static('desktop/ext/css/cui/bootstrap-responsive2.css') }" rel="stylesheet">

  <link href="${ static('desktop/ext/css/font-awesome.min.css') }" rel="stylesheet">
  <link href="${ static('desktop/css/hue3.css') }" rel="stylesheet">
  <link href="${ static('desktop/css/hue3-extra.css') }" rel="stylesheet">

  <style type="text/css">
    % if conf.CUSTOM.BANNER_TOP_HTML.get():
      body {
        display: none;
        visibility: hidden;
        padding-top: ${str(int(padding[:-2]) + 30) + 'px'};
      }
      .banner {
        height: 40px;
        width: 100%;
        padding: 0;
        position: fixed;
        top: 0;
        background-color: #F9F9F9;
        z-index: 1033;
      }
      .navigator {
        top: 30px!important;
      }
      .hue-title-bar {
        top: 58px!important;
      }
      % if current_app == "sqoop":
      .top-bar {
        top: 58px!important;
      }
      % endif

      % if current_app == "spark":
      .search-bar {
        top: 58px!important;
      }
      .show-assist {
        top: 110px!important;
      }
      % endif

    % else:
      body {
        display: none;
        visibility: hidden;
        padding-top: ${padding};
      }
    % endif
  </style>

  ${ commonHeaderFooterComponents.header_i18n_redirection(user, is_s3_enabled, apps) }

  <script src="${ static('desktop/js/hue.utils.js') }"></script>
  <script src="${ static('desktop/ext/js/jquery/jquery-2.1.1.min.js') }"></script>
  <script src="${ static('desktop/js/jquery.migration.js') }"></script>
  <script src="${ static('desktop/js/jquery.hiveautocomplete.js') }"></script>
  <script src="${ static('desktop/js/jquery.hdfsautocomplete.js') }"></script>
  <script src="${ static('desktop/js/jquery.filechooser.js') }"></script>
  <script src="${ static('desktop/js/jquery.selector.js') }"></script>
  <script src="${ static('desktop/js/jquery.delayedinput.js') }"></script>
  <script src="${ static('desktop/js/jquery.rowselector.js') }"></script>
  <script src="${ static('desktop/js/jquery.notify.js') }"></script>
  <script src="${ static('desktop/js/jquery.titleupdater.js') }"></script>
  <script src="${ static('desktop/js/jquery.horizontalscrollbar.js') }"></script>
  <script src="${ static('desktop/js/jquery.tablescroller.js') }"></script>
  <script src="${ static('desktop/js/jquery.tableextender.js') }"></script>
  <script src="${ static('desktop/js/jquery.tableextender2.js') }"></script>
  <script src="${ static('desktop/js/jquery.scrollleft.js') }"></script>
  <script src="${ static('desktop/js/jquery.scrollup.js') }"></script>
  <script src="${ static('desktop/js/jquery.tour.js') }"></script>
  <script src="${ static('desktop/ext/js/jquery/plugins/jquery.cookie.js') }"></script>
  <script src="${ static('desktop/ext/js/jquery/plugins/jquery.total-storage.min.js') }"></script>
  <script src="${ static('desktop/ext/js/jquery/plugins/jquery.dataTables.1.8.2.min.js') }"></script>
  <script src="${ static('desktop/ext/js/jquery/plugins/jquery.form.js') }"></script>
  <script src="${ static('desktop/js/jquery.huedatatable.js') }"></script>
  <script src="${ static('desktop/js/jquery.nicescroll.js') }"></script>
  <script src="${ static('desktop/js/jquery.datatables.sorting.js') }"></script>
  <script src="${ static('desktop/ext/js/d3.v3.js') }"></script>
  <script src="${ static('desktop/ext/js/d3.v4.js') }"></script>
  <script src="${ static('desktop/ext/js/bootstrap.min.js') }"></script>
  <script src="${ static('desktop/js/bootstrap-tooltip.js') }"></script>
  <script src="${ static('desktop/ext/js/bootstrap-better-typeahead.min.js') }"></script>
  <script src="${ static('desktop/js/hue.colors.js') }"></script>
  <script src="${ static('desktop/ext/js/fileuploader.js') }"></script>
  <script src="${ static('desktop/ext/js/filesize.min.js') }"></script>
  <script src="${ static('desktop/js/popover-extra-placements.js') }"></script>
  <script src="${ static('desktop/ext/js/moment-with-locales.min.js') }"></script>
  <script src="${ static('desktop/ext/js/knockout.min.js') }"></script>
  <script src="${ static('desktop/ext/js/knockout-mapping.min.js') }"></script>
  <script src="${ static('desktop/ext/js/knockout.validation.min.js') }"></script>
  <script src="${ static('desktop/js/ko.switch-case.js') }"></script>
  <script src="${ static('desktop/js/ko.hue-bindings.js') }"></script>
  <script src="${ static('desktop/js/sqlUtils.js') }"></script>
  <script src="${ static('desktop/ext/js/dropzone.min.js') }"></script>

  <script src="${ static('metastore/js/metastore.model.js') }"></script>

  ${ koComponents.all() }

  ${ commonHeaderFooterComponents.header_pollers(user, is_s3_enabled, apps) }

  <script type="text/javascript">
    var IS_HUE_4 = false;

    huePubSub.subscribe('get.current.app.name', function () {
      var appName = '';
      if ('${ 'metastore' in apps }' === 'True' && location.href.indexOf('${"metastore" in apps and apps["metastore"].display_name}') !== -1) {
        appName = 'metastore';
      } else if (location.href.indexOf('${ url('notebook:editor') }') !== -1) {
        appName = 'editor'
      }
      huePubSub.publish('set.current.app.name', appName);
    });
  </script>

</head>
<body>

${ hueIcons.symbols() }

% if conf.CUSTOM.BANNER_TOP_HTML.get():
  <div class="banner">
    ${ conf.CUSTOM.BANNER_TOP_HTML.get() | n,unicode }
  </div>
% endif

<%
  def count_apps(apps, app_list):
    count = 0
    found_app = ""
    for app in app_list:
      if app in apps:
       found_app = app
       count += 1
    return found_app, count
%>
% if not skip_topbar:
<div class="navigator">
  <div class="pull-right">

  % if user.is_authenticated() and section != 'login':
  <ul class="nav nav-pills">
    <li class="divider-vertical"></li>
    % if 'filebrowser' in apps:
      % if not is_s3_enabled:
      <li class="hide1380">
        <a title="${_('Manage HDFS')}" data-rel="navigator-tooltip" href="/${apps['filebrowser'].display_name}">
          <i class="fa fa-file"></i>&nbsp;${_('File Browser')}&nbsp;
        </a>
      </li>
      % else:
        <li class="dropdown hide1380">
          <a title="${_('File Browsers')}" data-rel="navigator-tooltip" href="#" data-toggle="dropdown" class="dropdown-toggle">
            <i class="fa fa-file"></i>&nbsp;${_('File Browsers')} <b class="caret"></b>
          </a>
          <ul role="menu" class="dropdown-menu">
            <li><a href="/${apps['filebrowser'].display_name}">
              <i class="fa fa-fw fa-file" style="vertical-align: middle"></i>${_('HDFS Browser')}</a>
            </li>
            <li><a href="/${apps['filebrowser'].display_name}/view=S3A://">
              <i class="fa fa-fw fa-cubes" style="vertical-align: middle"></i>${_('S3 Browser')}</a>
            </li>
          </ul>
        </li>
      % endif
      <li class="hideMoreThan1380">
        <a title="${_('HDFS Browser')}" data-rel="navigator-tooltip" href="/${apps['filebrowser'].display_name}">
          <i class="fa fa-file"></i>
        </a>
      </li>
      <li class="hideMoreThan1380">
        % if is_s3_enabled:
          <a title="${_('S3 Browser')}" data-rel="navigator-tooltip" href="/${apps['filebrowser'].display_name}/view=S3A://">
            <i class="fa fa-cubes"></i>
          </a>
        % endif
      </li>
    % endif
    % if 'jobbrowser' in apps:
      <li class="hide1380"><a title="${_('Manage jobs')}" data-rel="navigator-tooltip" href="/${apps['jobbrowser'].display_name}"><i class="fa fa-list-alt"></i>&nbsp;${_('Job Browser')}&nbsp;<span id="jobBrowserCount" class="badge badge-warning hide" style="padding-top:0;padding-bottom: 0"></span></a></li>
      <li class="hideMoreThan1380"><a title="${_('Job Browser')}" data-rel="navigator-tooltip" href="/${apps['jobbrowser'].display_name}"><i class="fa fa-list-alt"></i></a></li>
      <% from jobbrowser.conf import ENABLE_V2 %>
      % if ENABLE_V2.get():
        <li class="hide1380"><a title="${_('Manage jobs')}" data-rel="navigator-tooltip" href="/jobbrowser/apps">
          <i class="fa fa-list-alt"></i>&nbsp;${_('Job Browser 2')}&nbsp;<span id="jobBrowserCount" class="badge badge-warning hide" style="padding-top:0;padding-bottom: 0"></span></a>
        </li>
        <li class="hideMoreThan1380"><a title="${_('Job Browser 2')}" data-rel="navigator-tooltip" href="/jobbrowser/apps"><i class="fa fa-list-alt"></i></a></li>
      % endif
    % endif
    <%
      view_profile = user.has_hue_permission(action="access_view:useradmin:edit_user", app="useradmin") or user.is_superuser
    %>
    % if view_profile:
      <li class="dropdown">
        <a title="${ _('Administration') }" href="#" data-rel="navigator-tooltip" data-toggle="dropdown" class="dropdown-toggle">
          <i class="fa fa-cogs"></i>&nbsp;${user.username}&nbsp;
          <b class="caret"></b>
        </a>
        <ul class="dropdown-menu pull-right">
          <li>
            <a href="${ url('useradmin.views.edit_user', username=user.username) }"><i class="fa fa-key"></i>&nbsp;&nbsp;
              % if is_ldap_setup:
                ${_('View Profile')}
              % else:
                ${_('Edit Profile')}
              % endif
            </a>
          </li>
          % if user.is_superuser:
            <li><a href="${ url('useradmin.views.list_users') }"><i class="fa fa-group"></i>&nbsp;&nbsp;${_('Manage Users')}</a></li>
          % endif
        </ul>
      </li>
    % else:
      <li><a title="" data-rel="navigator-tooltip" href="#"><i class="fa fa-user"></i>&nbsp;${user.username}</a></li>
    % endif
    % if 'help' in apps:
    <li><a title="${_('Documentation')}" data-rel="navigator-tooltip" href="/help"><i class="fa fa-question-circle"></i></a></li>
    % endif
    <li id="jHueTourFlagPlaceholder"></li>
    <li><a title="${_('Sign out')}" data-rel="navigator-tooltip" href="/accounts/logout/"><i class="fa fa-sign-out"></i></a></li>
  </ul>
  % else:
  <ul class="nav nav-pills" style="margin-right: 40px">
    <li id="jHueTourFlagPlaceholder"></li>
  </ul>
  % endif

  </div>
    <a class="brand nav-tooltip pull-left" title="${_('About Hue')}" data-rel="navigator-tooltip" href="/about">
      <svg style="margin-top: 2px; margin-left:8px;width: 60px;height: 16px;display: inline-block;">
        <use xlink:href="#hi-logo"></use>
      </svg>
    </a>
    % if user.is_authenticated() and section != 'login':
     <ul class="nav nav-pills pull-left">
       <li><a title="${_('My documents')}" data-rel="navigator-tooltip" href="${ home_url }" style="padding-bottom:2px!important"><i class="fa fa-home" style="font-size: 19px"></i></a></li>
       <%
         query_apps = count_apps(apps, ['beeswax', 'impala', 'rdbms', 'pig', 'jobsub', 'spark']);
       %>
       % if query_apps[1] > 1:
       <li class="dropdown oozie">
         <a title="${_('Query data')}" data-rel="navigator-tooltip" href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-terminal inline-block hideMoreThan950"></i><span class="hide950">Query Editors</span> <b class="caret"></b></a>
         <ul role="menu" class="dropdown-menu">
           % if 'beeswax' in apps:
             % if USE_NEW_EDITOR.get():
             <li><a href="${ url('notebook:editor') }?type=hive"><img src="${ static(apps['beeswax'].icon_path) }" class="app-icon" alt="${ _('Hive icon') }"/> ${_('Hive')}</a></li>
             % else:
             <li><a href="/${apps['beeswax'].display_name}"><img src="${ static(apps['beeswax'].icon_path) }" class="app-icon" alt="${ _('Hive icon') }"/> ${_('Hive')}</a></li>
             % endif
           % endif
           % if 'impala' in apps:
             % if USE_NEW_EDITOR.get(): ## impala requires beeswax anyway
             <li><a href="${ url('notebook:editor') }?type=impala"><img src="${ static(apps['impala'].icon_path) }" class="app-icon" alt="${ _('Impala icon') }"/> ${_('Impala')}</a></li>
             % else:
             <li><a href="/${apps['impala'].display_name}"><img src="${ static(apps['impala'].icon_path) }" class="app-icon" alt="${ _('Impala icon') }"/> ${_('Impala')}</a></li>
             % endif
           % endif
           % if 'rdbms' in apps:
             % if USE_NEW_EDITOR.get():
             <li><a href="/${apps['rdbms'].display_name}"><img src="${ static(apps['rdbms'].icon_path) }" class="app-icon" alt="${ _('DBQuery icon') }"/> ${_('DB Query')}</a></li>
             % else:
             <li><a href="/${apps['rdbms'].display_name}"><img src="${ static(apps['rdbms'].icon_path) }" class="app-icon" alt="${ _('DBQuery icon') }"/> ${_('DB Query')}</a></li>
             % endif
           % endif
           % if 'pig' in apps:
             % if USE_NEW_EDITOR.get() and False:
             <li><a href="${ url('notebook:editor') }?type=pig"><img src="${ static(apps['pig'].icon_path) }" class="app-icon" alt="${ _('Pig icon') }"/> ${_('Pig')}</a></li>
             % else:
             <li><a href="/${apps['pig'].display_name}"><img src="${ static(apps['pig'].icon_path) }" class="app-icon" alt="${ _('Pig icon') }"/> ${_('Pig')}</a></li>
             % endif
           % endif
           % if 'jobsub' in apps:
             <li><a href="/${apps['jobsub'].display_name}"><img src="${ static(apps['jobsub'].icon_path) }" class="app-icon" alt="${ _('Job designer icon') }"/> ${_('Job Designer')}</a></li>
           % endif
         </ul>
       </li>
       % elif query_apps[1] == 1:
          <li><a href="/${apps[query_apps[0]].display_name}"><i class="fa fa-terminal hideMoreThan950"></i><span class="hide950">${apps[query_apps[0]].nice_name}</span></a></li>
       % endif
       % if 'beeswax' in apps:
        <%
          from notebook.conf import SHOW_NOTEBOOKS
        %>
        % if SHOW_NOTEBOOKS.get():
         <% from desktop.models import Document2, Document %>
         <% notebooks = [d.content_object.to_dict() for d in Document.objects.get_docs(user, Document2, extra='notebook') if not d.content_object.is_history] %>
         % if not notebooks:
           <li>
             <a title="${_('Notebook')}" data-rel="navigator-tooltip" href="${ url('notebook:new') }"><i class="fa fa-files-o hideMoreThan950"></i><span class="hide950">${_('Notebooks')}</span></a>
           </li>
         % else:
           <li class="dropdown">
             <a title="${_('Notebook')}" data-rel="navigator-tooltip" href="#" data-toggle="dropdown" class="dropdown-toggle">
               <i class="fa fa-files-o inline-block hideMoreThan950"></i><span class="hide950">${_('Notebooks')}</span> <b class="caret"></b>
             </a>
             <ul role="menu" class="dropdown-menu">
               <li><a href="${ url('notebook:new') }"><i class="fa fa-fw fa-plus" style="vertical-align: middle"></i>${_('Notebook')}</a></li>
               <li><a href="${ url('notebook:notebooks') }"><i class="fa fa-fw fa-tags" style="vertical-align: middle"></i>${_('Notebooks')}</a></li>
               <li class="divider"></li>
               % for notebook in notebooks:
                 <li>
                   <a href="${ url('notebook:notebook') }?notebook=${ notebook['id'] }">
                     <i class="fa fa-file-text-o" style="vertical-align: middle"></i> ${ notebook['name'] |n }
                   </a>
                 </li>
               % endfor
             </ul>
           </li>
          % endif
        % endif
      % endif
       <%
         data_apps = count_apps(apps, ['metastore', 'hbase', 'sqoop', 'zookeeper']);
       %>
       % if data_apps[1] > 1:
       <li class="dropdown">
         <a title="${_('Manage data')}" data-rel="navigator-tooltip" href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-database inline-block hideMoreThan950"></i><span class="hide950">Data Browsers</span> <b class="caret"></b></a>
         <ul role="menu" class="dropdown-menu">
           % if 'metastore' in apps:
             <li><a href="/${apps['metastore'].display_name}"><img src="${ static(apps['metastore'].icon_path) }" class="app-icon" alt="${ _('Metastore icon') }"/> ${_('Metastore Tables')}</a></li>
           % endif
           % if 'hbase' in apps:
             <li><a href="/${apps['hbase'].display_name}"><img src="${ static(apps['hbase'].icon_path) }" class="app-icon" alt="${ _('HBase icon') }"/> ${_('HBase')}</a></li>
           % endif
           % if 'sqoop' in apps:
             <li><a href="/${apps['sqoop'].display_name}"><img src="${ static(apps['sqoop'].icon_path) }" class="app-icon" alt="${ _('Sqoop icon') }"/> ${_('Sqoop Transfer')}</a></li>
           % endif
           % if 'zookeeper' in apps:
             <li><a href="/${apps['zookeeper'].display_name}"><img src="${ static(apps['zookeeper'].icon_path) }" class="app-icon" alt="${ _('ZooKeeper icon') }"/> ${_('ZooKeeper')}</a></li>
           % endif
         </ul>
       </li>
       % elif data_apps[1] == 1:
         <li><a href="/${apps[data_apps[0]].display_name}">${apps[data_apps[0]].nice_name}</a></li>
       % endif
       % if 'oozie' in apps:
       <li class="dropdown oozie">
         <a title="${_('Schedule with Oozie')}" data-rel="navigator-tooltip" href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-random inline-block hideMoreThan950"></i><span class="hide950">Workflows</span> <b class="caret"></b></a>
         <ul role="menu" class="dropdown-menu">
           <li class="dropdown-submenu">
             <a href="${ url('oozie:index') }"><img src="${ static('oozie/art/icon_oozie_dashboard_48.png') }" class="app-icon"  alt="${ _('Oozie dashboard icon') }"/> ${_('Dashboards')}</a>
             <ul class="dropdown-menu">
               <li><a href="${url('oozie:list_oozie_workflows')}"><img src="${ static('oozie/art/icon_oozie_workflow_48.png') }" class="app-icon" alt="${ _('Oozie workflow icon') }"/> ${_('Workflows')}</a></li>
               <li><a href="${url('oozie:list_oozie_coordinators')}"><img src="${ static('oozie/art/icon_oozie_coordinator_48.png') }" class="app-icon" alt="${ _('Oozie coordinator icon') }"/> ${_('Coordinators')}</a></li>
               <li><a href="${url('oozie:list_oozie_bundles')}"><img src="${ static('oozie/art/icon_oozie_bundle_48.png') }" class="app-icon" alt="${ _('Oozie bundles icon') }" /> ${_('Bundles')}</a></li>
             </ul>
           </li>
           % if not user.has_hue_permission(action="disable_editor_access", app="oozie") or user.is_superuser:
           <% from oozie.conf import ENABLE_V2 %>
           % if not ENABLE_V2.get():
           <li class="dropdown-submenu">
             <a href="${ url('oozie:list_workflows') }"><img src="${ static('oozie/art/icon_oozie_editor_48.png') }" class="app-icon" alt="${ _('Oozie editor icon') }" /> ${_('Editors')}</a>
             <ul class="dropdown-menu">
               <li><a href="${url('oozie:list_workflows')}"><img src="${ static('oozie/art/icon_oozie_workflow_48.png') }" class="app-icon" alt="${ _('Oozie workflow icon') }"/> ${_('Workflows')}</a></li>
               <li><a href="${url('oozie:list_coordinators')}"><img src="${ static('oozie/art/icon_oozie_coordinator_48.png') }" class="app-icon" alt="${ _('Oozie coordinator icon') }" /> ${_('Coordinators')}</a></li>
               <li><a href="${url('oozie:list_bundles')}"><img src="${ static('oozie/art/icon_oozie_bundle_48.png') }" class="app-icon" alt="${ _('Oozie bundle icon') }" /> ${_('Bundles')}</a></li>
             </ul>
           </li>
           % else:
           <li class="dropdown-submenu">
             <a href="${ url('oozie:list_editor_workflows') }"><img src="${ static('oozie/art/icon_oozie_editor_48.png') }" class="app-icon" alt="${ _('Oozie editor icon') }" /> ${_('Editors')}</a>
             <ul class="dropdown-menu">
               <li><a href="${url('oozie:list_editor_workflows')}"><img src="${ static('oozie/art/icon_oozie_workflow_48.png') }" class="app-icon" alt="${ _('Oozie workflow icon') }"/> ${_('Workflows')}</a></li>
               <li><a href="${url('oozie:list_editor_coordinators')}"><img src="${ static('oozie/art/icon_oozie_coordinator_48.png') }" class="app-icon" alt="${ _('Oozie coordinator icon') }" /> ${_('Coordinators')}</a></li>
               <li><a href="${url('oozie:list_editor_bundles')}"><img src="${ static('oozie/art/icon_oozie_bundle_48.png') }" class="app-icon" alt="${ _('Oozie bundle icon') }" /> ${_('Bundles')}</a></li>
             </ul>
           </li>
           % endif
           % endif
         </ul>
       </li>
       % endif
       % if 'search' in apps:
         <% from dashboard.controller import DashboardController %>
         <% controller = DashboardController(user) %>
         <% collections = controller.get_shared_search_collections() %>
         % if not collections:
           <li>
             <a title="${_('Solr Search')}" data-rel="navigator-tooltip" href="${ url('search:index') }">${_('Search')}</a>
           </li>
         % else:
           <li class="dropdown">
             <a title="${_('Solr Search')}" data-rel="navigator-tooltip" href="#" data-toggle="dropdown" class="dropdown-toggle">
               <i class="fa fa-search inline-block hideMoreThan950"></i><span class="hide950">${_('Search')}</span> <b class="caret"></b>
             </a>
             <ul role="menu" class="dropdown-menu">
               <li><a href="${ url('search:new_search') }" style="height: 24px; line-height: 24px!important;"><i class="fa fa-plus" style="vertical-align: middle"></i> ${ _('Dashboard') }</a></li>
               <li><a href="${ url('search:admin_collections') }" style="height: 24px; line-height: 24px!important;"><i class="fa fa-tags" style="vertical-align: middle"></i>${ _('Dashboards') }</a></li>
               <li><a href="${ url('indexer:collections') }" style="height: 24px; line-height: 24px!important;"><i class="fa fa-database" style="vertical-align: middle"></i> ${ _('Indexes') }</a></li>
               <%!
                 from indexer.conf import ENABLE_NEW_INDEXER
               %>
               % if ENABLE_NEW_INDEXER.get():
                 <li><a href="${ url('indexer:indexer') }" style="height: 24px; line-height: 24px!important;"><i class="fa fa-plus" style="vertical-align: middle"></i> ${ _('Index') }</a></li>
               % endif
               <li class="divider"></li>
               % for collection in collections:
                 <li>
                   <a href="${ url('search:index') }?collection=${ collection.id }">
                     <img src="${ static(controller.get_icon(collection.name)) }" class="app-icon" alt="${ _('Collection icon') }"/> ${ collection.name }
                   </a>
                 </li>
               % endfor
             </ul>
           </li>
         % endif
       % endif
       % if 'security' in apps:
         <% from security.conf import HIVE_V1, HIVE_V2, SOLR_V2 %>
         <li class="dropdown">
           <a title="${_('Hadoop Security')}" data-rel="navigator-tooltip" href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-unlock inline-block hideMoreThan950"></i><span class="hide950">Security</span> <b class="caret"></b></a>
           <ul role="menu" class="dropdown-menu">
             % if HIVE_V1.get():
             <li><a href="${ url('security:hive') }">&nbsp;<img src="/static/metastore/art/icon_metastore_48.png" class="app-icon" alt="${ _('Metastore icon') }"> ${_('Hive Tables')}</a></li>
             % endif
             % if HIVE_V2.get():
             <li><a href="${ url('security:hive2') }">&nbsp;<img src="/static/metastore/art/icon_metastore_48.png" class="app-icon" alt="${ _('Metastore icon') }"> ${_('Hive Tables v2')}</a></li>
             % endif
             % if SOLR_V2.get():
             <li><a href="${ url('security:solr') }">&nbsp;<i class="fa fa-database"></i>&nbsp;${_('Solr Collections')}</a></li>
             % endif
             <li><a href="${ url('security:hdfs') }">&nbsp;<i class="fa fa-file"></i>&nbsp;${_('File ACLs')}</a></li>
           </ul>
         </li>
       % endif
       % if other_apps:
       <li class="dropdown">
         <a href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-tasks inline-block hideMoreThan950"></i><span class="hide950">${_('Other apps')}</span> <b class="caret"></b></a>
         <ul role="menu" class="dropdown-menu">
           % for other in other_apps:
             <li><a href="/${ other.display_name }"><img src="${ static(other.icon_path) }" class="app-icon" alt="${ _('App icon') }"/> ${ other.nice_name }</a></li>
           % endfor
         </ul>
       </li>
       % endif
     </ul>
   % endif

</div>
% endif

% if is_demo:
  <ul class="side-labels unstyled">
    <li class="feedback"><a href="javascript:showClassicWidget()"><i class="fa fa-envelope-o"></i> ${_('Feedback')}</a></li>
  </ul>

  <!-- UserVoice JavaScript SDK -->
  <script>(function(){var uv=document.createElement('script');uv.type='text/javascript';uv.async=true;uv.src='//widget.uservoice.com/8YpsDfIl1Y2sNdONoLXhrg.js';var s=document.getElementsByTagName('script')[0];s.parentNode.insertBefore(uv,s)})()</script>
  <script>
  UserVoice = window.UserVoice || [];
  function showClassicWidget() {
    UserVoice.push(['showLightbox', 'classic_widget', {
      mode: 'feedback',
      primary_color: '#338cb8',
      link_color: '#338cb8',
      forum_id: 247008
    }]);
  }
  </script>
% endif

<div id="jHueNotify" class="alert alert-dismissible alert-warning hide">
  <button type="button" class="close" data-dismiss="alert">
    <span aria-hidden="true">&times;</span>
    <span class="sr-only">${ _('Close') }</span>
  </button>
  <p class="message"></p>
</div>
