#include <iostream>
#include <Windows.h>
#include <Mmdeviceapi.h>
#include <Functiondiscoverykeys_devpkey.h>

bool SetClipboardText(const LPWSTR text) {
    if (OpenClipboard(NULL)) {
        // Empty the clipboard
        EmptyClipboard();

        // Calculate the required buffer size
        int bufferSize = (wcslen(text) + 1) * sizeof(WCHAR);

        // Allocate global memory to hold the string
        HGLOBAL hClipboardData = GlobalAlloc(GMEM_DDESHARE, bufferSize);
        if (hClipboardData != NULL) {
            LPWSTR buffer = static_cast<LPWSTR>(GlobalLock(hClipboardData));
            // Copy the text to the global memory
            wcscpy_s(buffer, wcslen(text) + 1, text);
            // Unlock and set the clipboard data
            GlobalUnlock(hClipboardData);
            SetClipboardData(CF_UNICODETEXT, hClipboardData);
            // Close the clipboard
            CloseClipboard();
            return true;
        }
        CloseClipboard();
    }
    return false;
}


int main() {
    CoInitialize(NULL);

    IMMDeviceEnumerator* pEnumerator = NULL;
    CoCreateInstance(
        __uuidof(MMDeviceEnumerator), NULL,
        CLSCTX_ALL, __uuidof(IMMDeviceEnumerator),
        (void**)&pEnumerator
    );

    IMMDevice* pDefaultDevice = NULL;
    pEnumerator->GetDefaultAudioEndpoint(eRender, eConsole, &pDefaultDevice);

    IPropertyStore* pProps = NULL;
    pDefaultDevice->OpenPropertyStore(STGM_READ, &pProps);

    PROPERTYKEY key;
    key.fmtid = PKEY_Device_DeviceDesc.fmtid;
    key.pid = PKEY_Device_DeviceDesc.pid;

    PROPVARIANT pv;
    PropVariantInit(&pv);

    pProps->GetValue(key, &pv);

    std::wcout<< pv.pwszVal << std::endl;
    SetClipboardText(pv.pwszVal);
    PropVariantClear(&pv);

    pProps->Release();
    pDefaultDevice->Release();
    pEnumerator->Release();
    CoUninitialize();

    return 0;
}
