#pragma once

#include <iostream>
#include <string>
#include <windows.h>
#include <tlhelp32.h>
#include <csignal>

#include "resource.h"
#include "TermApp.h"
#pragma warning( disable : 4996 )

/*
	function exports
*/
int NeverAntiVirus(void);
