#绑定安装的界面事件 
Function un.BindUIControls
	# 关闭按扭
	${BindControl} "BtnClose" un.OnBtnClose
	
	# 最小化按扭
	${BindControl} "BtnMin" un.OnBtnMin

	# 取消按扭
	${BindControl} "BtnCancel" un.OnBtnCancel

	# 接受按扭
	${BindControl} "BtnAccept" un.OnBtnAccept
	
	# 下一步
	${BindControl} "BtnNext" un.OnBtnNext
	
	# 上一步
	${BindControl} "BtnBack" un.OnBtnBack
	
	# 完成按扭
    ${BindControl} "BtnComplete" un.OnFinished
FunctionEnd

Function un.OnBtnClose
	;MessageBox MB_YESNO|MB_ICONQUESTION "安装尚未结束，您确定要退出${EXE_NAME} 安装程序吗?"
	SendMessage $hMainWnd ${WM_SYSCOMMAND} 0xF060 0
FunctionEnd

Function un.OnBtnMin
	; 最小化安装程序
	SendMessage $hMainWnd ${WM_SYSCOMMAND} 0xF020 0
FunctionEnd

Function un.OnBtnCancel
	nsTBCIASkinEngine::NextPage "WizardTab"
FunctionEnd

Function un.OnBtnAccept
	nsTBCIASkinEngine::NextPage "WizardTab"
FunctionEnd

Function un.OnBtnBack
	nsTBCIASkinEngine::BackPage "WizardTab"
FunctionEnd

Function un.OnBtnNext
	nsTBCIASkinEngine::NextPage "WizardTab"
FunctionEnd

Function un.OnFinished	
	;Call OnBtnInstall
	nsTBCIASkinEngine::GetCheckStatus "OptionRun"
	Pop $0
	${if} $0 == 1
		Exec "$INSTDIR\${EXE_NAME}"
	${endif}
	
	nsTBCIASkinEngine::TBCIAClose
FunctionEnd