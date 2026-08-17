#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:globals.glsl> 

precision highp float;






#define hue(v)  ((.6+.6*cos(6.*(v)+vec4(0, 23, 21, 1)))+vec4(0., 0., 0., 1.) )

#define finalize() { \
    vertexDistance=length((ModelViewMat*vertex).xyz); \
    texCoord0=UV0; \
}

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;


uniform sampler2D Sampler0;

uniform sampler2D Sampler2;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

out float sphericalVertexDistance;
out float cylindricalVertexDistance;

float safeGameTime() {
    float gameTime=GameTime;
    
    if(gameTime <= 0) {
        gameTime=.5;
    }
    return gameTime;
}

float scaledTime() {
    return safeGameTime()*12000.;
}

void f_d029afd7(inout vec4 vertex) {
    gl_Position=ProjMat*ModelViewMat*vertex;
}

void f_5226091b() {
    vertexColor=Color*texelFetch(Sampler2, UV2 / 16, 0);
}


void f_851381d4(inout vec4 vertex) {
    f_d029afd7(vertex);
    if(Position.z==0. && gl_Position.x > .95) {
        vertexColor=vec4(0);
    }else{
        f_5226091b();
    }
    finalize();
}



void f_b0501cbc() {
    vertexColor=hue(gl_Position.x+safeGameTime()*1000.)*texelFetch(Sampler2, UV2 / 16, 0);
}

void f_96985709() {
    gl_Position.y+=sin(scaledTime()+(gl_Position.x*6)) / 150.;
}

void f_15bf641e(inout vec4 vertex) {
    f_d029afd7(vertex);
    f_b0501cbc();
    finalize();
}

void f_6c444875(inout vec4 vertex) {
    f_d029afd7(vertex);
    f_5226091b();
    f_96985709();
    finalize();
}

void f_3c542d6e(inout vec4 vertex) {
    f_d029afd7(vertex);
    f_96985709();
    f_b0501cbc();
    finalize();
}

void f_0e84047d(inout vec4 vertex) {
    f_5226091b();
    float vertexId=mod(gl_VertexID, 4.);
    if(vertex.z <= 0.) {
        if(vertexId==3. || vertexId==0.) {
            vertex.y+=cos(scaledTime() / 4)*.1;
            vertex.y+=max(cos(scaledTime() / 4)*.1, 0.);
        }
    }else{
        if(vertexId==3. || vertexId==0.) {
            vertex.y-=cos(scaledTime() / 4)*3;
            vertex.y-=max(cos(scaledTime() / 4)*4, 0.);
        }
    }
    f_d029afd7(vertex);
    finalize();
}

void f_c18607f1(inout vec4 vertex) {
    float vertexId=mod(gl_VertexID, 4.);
    if(vertex.z <= 0.) {
        if(vertexId==3. || vertexId==0.) {
            vertex.y+=cos(scaledTime() / 4)*.1;
            vertex.y+=max(cos(scaledTime() / 4)*.1, 0.);
        }
    }else{
        if(vertexId==3. || vertexId==0.) {
            vertex.y-=cos(scaledTime() / 4)*3;
            vertex.y-=max(cos(scaledTime() / 4)*4, 0.);
        }
    }
    f_b0501cbc();
    f_d029afd7(vertex);
    finalize();
}

void f_24f134e2(inout vec4 vertex, float speed) {
    f_d029afd7(vertex);
    float blink=abs(sin(scaledTime()*speed));
    vertexColor=Color*blink*texelFetch(Sampler2, UV2 / 16, 0);
    finalize();
}



void f_6b3b5d20(inout vec4 vertex) {
    f_d029afd7(vertex);
    f_5226091b();
    vertexColor=vec4(1, 1, 1, vertexColor.a); 
    finalize();
}


void main() {

    sphericalVertexDistance=fog_spherical_distance(Position);
    cylindricalVertexDistance=fog_cylindrical_distance(Position);
    vertexColor=Color*texelFetch(Sampler2, UV2 / 16, 0);

    vec4 vertex=vec4(Position, 1.);
    ivec3 iColor=ivec3(Color.xyz*255+vec3(.5));

    
    
    if(iColor==ivec3(255, 85, 85))
    {
        f_851381d4(vertex);
        return;
    }
    

    
    if(fract(Position.z) < .1) {
        
        
        if(iColor==ivec3(19, 23, 9))
        {
            gl_Position=vec4(2, 2, 2, 1);
            f_5226091b();
            finalize();
            return;
        }
        

        
        
        if(iColor==ivec3(57, 63, 63)) {
            
            
            f_d029afd7(vertex);
            f_5226091b();
            finalize();
            return;
        }

        
        if(iColor==ivec3(57, 63, 62)) {
            f_6c444875(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 62, 63)) {
            
            f_6c444875(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 62, 62)) {
            f_0e84047d(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 61, 63)) {
            f_0e84047d(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 61, 62)) {
            f_24f134e2(vertex, .5);
            return;
        }

        

        
    }

    
    
    if(iColor==ivec3(78, 92, 36))
    {
        f_6b3b5d20(vertex);
        return;
    }
    

    
    
    
    if(iColor==ivec3(230, 255, 254))
    {
        f_15bf641e(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 255, 250))
    {
        f_6c444875(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 251, 254))
    {
        f_3c542d6e(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 251, 250))
    {
        f_0e84047d(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 247, 254))
    {
        f_c18607f1(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 247, 250))
    {
        f_24f134e2(vertex, .5);
        return;
    }

    
    

    
    
    
    if(iColor==ivec3(255, 255, 254))
    {
        f_15bf641e(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 253))
    {
        f_6c444875(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 25))
    {
        f_3c542d6e(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 251))
    {
        f_0e84047d(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 254, 254))
    {
        f_c18607f1(vertex);
        return;
    }
    

    
    f_d029afd7(vertex);
    f_5226091b();
    finalize();
}