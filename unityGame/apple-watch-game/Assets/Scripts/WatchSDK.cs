using UnityEngine;
using System;
using System.Runtime.InteropServices;

public class WatchSDK
{
    // import a single C-function from our plugin
    [DllImport ("__Internal")]
    private static extern void _SendMessage(string content);

    [DllImport ("__Internal")]
    private static extern void _RecievedMessage(string content);

    // wrap imported C-function to C# method
    public static void SendMessage(string content) {
        #if UNITY_IOS && !UNITY_EDITOR
        _SendMessage(content);
        #endif
    }

    public static void RecievedMessage(string content) {
        #if UNITY_IOS && !UNITY_EDITOR
        _RecievedMessage(content);
        #endif
    }
}