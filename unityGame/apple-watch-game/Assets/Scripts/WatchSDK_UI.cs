using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;

[Serializable]
public class Statistics
{
    public string GUID = "";
}

public class WatchSDK_UI : MonoBehaviour {

    public Rect ButtonDimension;
    public Rect LabelDimension;
    public GUISkin skin;

    private string lastGUIDGenerated = "No Set";

    void OnGUI(){
        if (GUI.Button (ButtonDimension, "Generate GUID", skin.button)) {
            lastGUIDGenerated = System.Guid.NewGuid ().ToString ();
            var s = new Statistics (){ GUID = lastGUIDGenerated };
            var content = JsonUtility.ToJson (s);
            WatchSDK.SendMessage(content);
        }

        GUI.Label (LabelDimension, lastGUIDGenerated, skin.label);
    }
}