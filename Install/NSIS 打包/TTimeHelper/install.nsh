;!include "nsProcess.nsh"
;!include "ttimehelper.nsh"
;!define UNINSTALL_REG_PATH	"Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_PATHNAME}"


#绑定安装的界面事件 
Function BindUIControls
	# 关闭按扭
	${BindControl} "BtnClose" OnBtnClose
	
	# 最小化按扭
	${BindControl} "BtnMin" OnBtnMin

	# 取消按扭
	${BindControl} "BtnCancel" OnBtnCancel

	# 接受按扭
	${BindControl} "BtnAccept" OnBtnAccept
	
	# 下一步
	${BindControl} "BtnNext" OnBtnNext
	
	# 上一步
	${BindControl} "BtnBack" OnBtnBack
	
	# 完成按扭
    ${BindControl} "BtnComplete" OnFinished
FunctionEnd

Function OnBtnInstall
	WriteUninstaller "$INSTDIR\uninst.exe"
	
	# 添加卸载信息到控制面板
	WriteRegStr HKLM "${UNINSTALL_REG_PATH}" "DisplayName" "${PRODUCT_NAME}"
	WriteRegStr HKLM "${UNINSTALL_REG_PATH}" "UninstallString" "$INSTDIR\uninst.exe"
	WriteRegStr HKLM "${UNINSTALL_REG_PATH}" "DisplayIcon" "$INSTDIR\${EXE_NAME}"
	WriteRegStr HKLM "${UNINSTALL_REG_PATH}" "Publisher" "${PRODUCT_PUBLISHER}"
	WriteRegStr HKLM "${UNINSTALL_REG_PATH}" "DisplayVersion" "${PRODUCT_VERSION}"
FunctionEnd

Function OnBtnClose
	;MessageBox MB_YESNO|MB_ICONQUESTION "安装尚未结束，您确定要退出${EXE_NAME} 安装程序吗?"
	SendMessage $hMainWnd ${WM_SYSCOMMAND} 0xF060 0
FunctionEnd

Function OnBtnMin
	; 最小化安装程序
	SendMessage $hMainWnd ${WM_SYSCOMMAND} 0xF020 0
FunctionEnd

Function OnBtnCancel
	nsTBCIASkinEngine::NextPage "WizardTab"
FunctionEnd

Function OnBtnAccept
	nsTBCIASkinEngine::NextPage "WizardTab"
FunctionEnd

Function OnBtnBack
	nsTBCIASkinEngine::BackPage "WizardTab"
FunctionEnd

Function OnBtnNext
	nsTBCIASkinEngine::NextPage "WizardTab"
FunctionEnd

Function OnFinished	
	Call OnBtnInstall
	nsTBCIASkinEngine::GetCheckStatus "OptionRun"
	Pop $0
	${if} $0 == 1
		Exec "$INSTDIR\${EXE_NAME}"
	${endif}
	
	nsTBCIASkinEngine::TBCIAClose
FunctionEnd