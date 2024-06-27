//? To calculate normal and light angles
varying vec3 vNormal;

//? to calculate reflection
varying vec3 vPosition;

void main()
{
    // Position
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);
    gl_Position = projectionMatrix * viewMatrix * modelPosition;

    

    // Varying
    
    // vNormal = normal; //! in this way the normals of the meshes are not rotating! 
    vec4 modelNormal = modelMatrix * vec4(normal, 0.0); // es cero para no aplicar la traslación
    vNormal = modelNormal.xyz;
    vPosition = modelPosition.xyz;

}