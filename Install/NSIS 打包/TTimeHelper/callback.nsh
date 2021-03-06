# ============================== 回调函数 ====================================

# 函数名以“.”开头的一般作为回调函数保留.
# 函数名以“un.”开头的函数将会被创建在卸载程序里，因此，普通安装区段和函数不能调用卸载函数，而卸载区段和卸载函数也不能调用普通函数。

Function .onInit
	${FindProcess} "${EXE_NAME}" $0
	${if} $0 == 0
		;MessageBox MB_ICONQUESTION|MB_YESNO "${EXE_NAME} 正在运行，是否强制退出！" /SD IDYES IDYES +2 IDNO +1
		nsTBCIASkinEngine::ShowMsgBox "${EXE_NAME} 正在运行，是否强制继续安装？" "提示"
		Pop $R0
		; 返回0代表结束运行，非0表示继续执行
		${if} $R0 == 0
			Abort
		${endif}
		
		${KillProcess} "${EXE_NAME}" $0
	${endif}
FunctionEnd


# 安装成功以后.
Function .onInstSuccess
	;MessageBox MB_ICONQUESTION|MB_YESNO "onInstSuccess" /SD IDYES IDYES +2 IDNO +1
	nsTBCIASkinEngine::GetCheckStatus "OptionRun"
	Pop $0
	${if} $0 == 1
		Call RunApp
	${endif}

FunctionEnd

# 在安装失败后用户点击“取消”按钮时被调用.
Function .onInstFailed
    MessageBox MB_ICONQUESTION|MB_YESNO "安装成功！" /SD IDYES IDYES +2 IDNO +1
FunctionEnd


# 每次用户更改安装路径的时候这段代码都会被调用一次.
Function .onVerifyInstDir

FunctionEnd

# 卸载操作开始前.
Function un.onInit
    ;MessageBox MB_ICONQUESTION|MB_YESNO "您确定要卸载${PRODUCT_NAME}吗?" /SD IDYES IDYES +2 IDNO +1
	nsTBCIASkinEngine::ShowMsgBox "您确定要卸载${PRODUCT_NAME}吗?" "提示"
    Pop $R0
	${if} $R0 == 0
		Abort
	${endif}
	
	${FindProcess} "${EXE_NAME}" $0
	${if} $0 == 0
		;MessageBox MB_ICONQUESTION|MB_YESNO "${PRODUCT_NAME} 正在运行，是否强制卸载?" /SD IDYES IDYES +2 IDNO +1
		nsTBCIASkinEngine::ShowMsgBox "${EXE_NAME} 正在运行，是否强制卸载?" "提示"
		Pop $R0
		${if} $R0 == 0
			Abort
		${endif}
		
		${KillProcess} "${EXE_NAME}" $0
	${endif}
FunctionEnd

# 卸载成功以后.
Function un.onUninstSuccess
	
FunctionEnd

# 安装成功以后启动应用程序
Function RunApp
	Exec "$INSTDIR\${EXE_NAME}"
FunctionEnd