; 脚本由 Inno Setup 脚本向导 生成！
; 有关创建 Inno Setup 脚本文件的详细资料请查阅帮助文档！
#define MyAppName "云机精灵管理器"
#define MyInstallFileVersion "1.0.0.0"
#define MyAppShowVersion "1.0.0"
#define MyAppPublisher "深圳市众联悠游科技有限公司"
#define MyAppURL "http://www.52uyou.com/"
#define MyAppExeName "UYouMain.exe"

#define IncludeFramework true
#define IsExternal ""
#define IsAdminLoggedOn true
;ClientApp是客户端程序所在的文件夹
#define SourceFileDir "E:\gitcode\uyouMonitor_1018\uyouMonitor\output"
#define UninstallGUID "{B2875B0D-BFEE-4DBE-BF9D-480823107BA3}"

[Setup]
; 注: AppId的值为单独标识该应用程序。
; 不要为其他安装程序使用相同的AppId值。
; (生成新的GUID，点击 工具|在IDE中生成GUID。)
AppId={{#UninstallGUID}
AppName={#MyAppName}
AppVersion={#MyInstallFileVersion}
AppVerName={#MyAppName} {#MyAppShowVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
Compression=lzma
SolidCompression=yes
AlwaysRestart=no
RestartIfNeededByRun = no
PrivilegesRequired=admin

;如果用户选择的文件夹已经存在，是否提示
DirExistsWarning=yes
;卸载程序所在的文件夹，将会与我们的程序存在于同一文件夹中
UninstallFilesDir={app}
;卸载程序所使用的图标 在添加删除程序中
UninstallDisplayIcon={app}\{#MyAppName}

#if IncludeFramework
  OutputBaseFilename=setup_FW
#else
  OutputBaseFilename=Setup
#endif

;输出目录

OutputDir={#SourceFileDir}\setup
;是否在程序组中允许卸载
Uninstallable=yes

UninstallDisplayName=卸载{#MyAppName}

[Languages]
Name: "chinesesimp"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: checkablealone; 
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: {#SourceFileDir}\NLog.dll; DestDir: "{app}"; Flags: ignoreversion 
Source: {#SourceFileDir}\NLog.Extended.dll; DestDir: "{app}"; Flags: ignoreversion 
Source: {#SourceFileDir}\NLog.config; DestDir: "{app}"; Flags: ignoreversion  
Source: {#SourceFileDir}\UYouMain.exe.config; DestDir: "{app}"; Flags: ignoreversion
Source: {#SourceFileDir}\UYouMain.exe; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceFileDir}\AxSVCBoxMonitorLib.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceFileDir}\SVCBoxMonitorLib.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceFileDir}\SVCBoxMonitor.ocx"; DestDir: "{app}"; Flags: ignoreversion regserver
Source: "{#SourceFileDir}\SVCBoxMonitorLib.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceFileDir}\System.Windows.Interactivity.dll"; DestDir: "{app}"; Flags: ignoreversion   
Source: "{#SourceFileDir}\Newtonsoft.Json.Net20.dll"; DestDir: "{app}"; Flags: ignoreversion   
Source: "{#SourceFileDir}\swscale-3.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceFileDir}\swresample-1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceFileDir}\avutil-54.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceFileDir}\avformat-56.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#SourceFileDir}\avcodec-56.dll"; DestDir: "{app}"; Flags: ignoreversion



#if IncludeFramework
;把.net framework 4.0放在另一个文件件中
Source: "{#SourceFileDir}\system\dotNetFx40_Full_x86_x64.exe"; DestDir: "{tmp}"; Flags: ignoreversion {#IsExternal}; Check: NeedsFramework
#endif
 

; 注意: 不要在任何共享系统文件上使用“Flags: ignoreversion”

[Icons]

Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"  ;WorkingDir:   "{app}" 
;桌面快捷方式
;ico2.ico是要在桌面显示的快捷方式的ico
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon ;WorkingDir:"{app}";  
;快速启动
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon   ;WorkingDir:   "{app}" 
;卸载
Name: "{group}\卸载{#MyAppName}"; Filename: "{uninstallexe}"

;注册开机启动 暂时不启用
;[Registry]
;注册表中添加自启动
;Root: HKLM; Subkey: "software\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "MyStartKey"; ValueData: "{app}\{#MyAppExeName} /s"; Flags: uninsdeletevalue


[Run]#if IncludeFramework
Filename: {tmp}\dotNetFx40_Full_x86_x64.exe; Parameters: "/q:a /c:""install /l /q"""; WorkingDir: {tmp}; Flags: skipifdoesntexist; StatusMsg: "正在安装程序运行所必须的.NET Framework4.0框架，大概需要2-5分钟，请稍后"
#endif
Filename: {win}\Microsoft.NET\Framework\v4.0.30319\CasPol.exe; Parameters: "-q -machine -remgroup ""{#MyAppName}"""; WorkingDir: {tmp}; Flags: skipifdoesntexist runhidden; StatusMsg: "设置程序访问权限..."
Filename: {win}\Microsoft.NET\Framework\v4.0.30319\CasPol.exe; Parameters: "-q -machine -addgroup 1.2 -url ""file://{app}/*"" FullTrust -name ""{#MyAppName}"""; WorkingDir: {tmp}; Flags: skipifdoesntexist runhidden; StatusMsg: "设置程序访问权限..."
Filename: "{app}\UYouMain.exe"; Description: "运行应用程序"; Flags: postinstall nowait skipifsilent

[UninstallRun]
Filename: "regsvr32"; Parameters:"/u /s ""{app}/SVCBoxMonitor.ocx""";

[code]
// Indicates whether .NET Framework 4.0 is installed.
function IsDotNET40Detected(): Boolean;
var
    success: boolean;
    install: cardinal;

begin
    success := RegQueryDWordValue(HKLM, 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full', 'Install', install);
   
    Result :=  success and (install = 1);
end;

//RETURNS OPPOSITE OF IsDotNet20Detected FUNCTION
//Remember this method from the Files section above
function NeedsFramework(): Boolean;
begin
  Result := (IsDotNET40Detected = false);
end;



function GetCustomSetupExitCode(): Integer;
begin
  if (IsDotNET40Detected = false) then
    begin
      MsgBox('.NET Framework 未能正确安装!',mbError, MB_OK);
      result := -1
    end
end;

//卸载程序
function InitializeUninstall(): Boolean;
var
  HasRun:HWND;
  ErrorCode: Integer;
begin
  ShellExec('open', 'taskkill', ' /f /im UYouMain.exe', '',SW_HIDE, ewNoWait, ErrorCode);
  ShellExec('open', 'taskkill', ' /f /im BoxManager.exe', '',SW_HIDE, ewNoWait, ErrorCode);
  ShellExec('open', 'taskkill', ' /f /im adb.exe', '',SW_HIDE, ewNoWait, ErrorCode);
  Result := true;
  //if Result = False then
  //  MsgBox('InitializeUninstall:' #13#13 'Ok, bye bye.', mbInformation, MB_OK);
end;


procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  ErrorCode: Integer;
begin
  case CurUninstallStep of
    usUninstall:
      begin
        //MsgBox('卸载程序:' #13#13 '正在卸载...', mbInformation, MB_OK)
        // ...insert code to perform pre-uninstall tasks here...
      end;
    usPostUninstall:
      begin
        //MsgBox('卸载程序:' #13#13 '卸载完成.', mbInformation, MB_OK);
        // ...insert code to perform post-uninstall tasks here...        
      end;
  end;
end;

function InitializeSetup():Boolean;
var 
  HasRun:HWND;
  ErrorCode: Integer;
  ResultStr: String;  
  ResultCode: Integer;
begin
  Result := true;
  ShellExec('open', 'taskkill', ' /f /im UYouMain.exe', '',SW_HIDE, ewNoWait, ErrorCode);
  ShellExec('open', 'taskkill', ' /f /im BoxManager.exe', '',SW_HIDE, ewNoWait, ErrorCode);
  ShellExec('open', 'taskkill', ' /f /im adb.exe', '',SW_HIDE, ewNoWait, ErrorCode);

  if RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#UninstallGUID}_is1', 'UninstallString', ResultStr) then
  begin
    ResultStr := RemoveQuotes(ResultStr);
    Exec(ResultStr, '', '', SW_SHOWNORMAL, ewWaitUntilTerminated, ErrorCode)
  end
end;
 