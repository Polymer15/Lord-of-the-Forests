using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TerrainController : MonoBehaviour {
    public int width = 32;

    private void Awake() {
        TerrainPointDirectory.Initialize(width);
    }

    void Start() {
        
    }

    // Update is called once per frame
    void Update() {
        
    }
}
