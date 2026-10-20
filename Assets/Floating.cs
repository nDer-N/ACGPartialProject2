using UnityEngine;

public class Floating : MonoBehaviour
{
    [Header("Movimiento")]
    [SerializeField] private float amplitude = 0.25f; // qué tanto sube y baja
    [SerializeField] private float speed = 1.5f;      // qué tan rápido flota

    private Vector3 startPos;

    private void Start()
    {
        startPos = transform.position;
    }

    private void Update()
    {
        float offset = Mathf.Sin(Time.time * speed) * amplitude;
        transform.position = startPos + Vector3.up * offset;
    }
}
