#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:globals.glsl> 
#moj_import <minecraft:sample_lightmap.glsl>

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

void f_4b6881fa(inout vec4 vertex) {
    gl_Position=ProjMat*ModelViewMat*vertex;
}

void f_0fd8035b() {
    vertexColor=Color*sample_lightmap(Sampler2, UV2);
}


void f_6afb9f4b(inout vec4 vertex) {
    f_4b6881fa(vertex);
    if(Position.z==0. && gl_Position.x > .95) {
        vertexColor=vec4(0);
    }else{
        f_0fd8035b();
    }
        finalize();
}



void f_0f116460() {
    vertexColor=hue(gl_Position.x+safeGameTime()*1000.)*sample_lightmap(Sampler2, UV2);
}

void f_6b112da5() {
    gl_Position.y+=sin(scaledTime()+(gl_Position.x*6)) / 150.;
}

void f_ca526293(inout vec4 vertex) {
    f_4b6881fa(vertex);
    f_0f116460();
    finalize();
}

void f_e1d427f6(inout vec4 vertex) {
    f_4b6881fa(vertex);
    f_0fd8035b();
    f_6b112da5();
    finalize();
}

void f_5a5f3d08(inout vec4 vertex) {
    f_4b6881fa(vertex);
    f_6b112da5();
    f_0f116460();
    finalize();
}

void f_d2464ffa(inout vec4 vertex) {
    f_0fd8035b();
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
    f_4b6881fa(vertex);
    finalize();
}

void f_0afec71a(inout vec4 vertex) {
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
    f_0f116460();
    f_4b6881fa(vertex);
    finalize();
}

void f_2fcac5a9(inout vec4 vertex, float speed) {
    f_4b6881fa(vertex);
    float blink=abs(sin(scaledTime()*speed));
    vertexColor=Color*blink*sample_lightmap(Sampler2, UV2);
    finalize();
}



void f_a8337eee(inout vec4 vertex) {
    f_4b6881fa(vertex);
    f_0fd8035b();
    vertexColor=vec4(1, 1, 1, vertexColor.a); 
    finalize();
}


void main() {

    sphericalVertexDistance=fog_spherical_distance(Position);
    cylindricalVertexDistance=fog_cylindrical_distance(Position);
    vertexColor=Color*sample_lightmap(Sampler2, UV2);

    vec4 vertex=vec4(Position, 1.);
    ivec3 iColor=ivec3(Color.xyz*255+vec3(.5));

    
    
    if(iColor==ivec3(255, 85, 85))
    {
        f_6afb9f4b(vertex);
        return;
    }
    

    
    if(fract(Position.z) < .1) {
        
        
        if(iColor==ivec3(19, 23, 9))
        {
            gl_Position=vec4(2, 2, 2, 1);
            f_0fd8035b();
            finalize();
            return;
        }
        

        
        
        if(iColor==ivec3(57, 63, 63)) {
            
            
            f_4b6881fa(vertex);
            f_0fd8035b();
            finalize();
            return;
        }

        
        if(iColor==ivec3(57, 63, 62)) {
            f_e1d427f6(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 62, 63)) {
            
            f_e1d427f6(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 62, 62)) {
            f_d2464ffa(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 61, 63)) {
            f_d2464ffa(vertex);
            return;
        }

        
        if(iColor==ivec3(57, 61, 62)) {
            f_2fcac5a9(vertex, .5);
            return;
        }

        

        
    }

    
    
    if(iColor==ivec3(78, 92, 36))
    {
        f_a8337eee(vertex);
        return;
    }
    

    
    
    
    if(iColor==ivec3(230, 255, 254))
    {
        f_ca526293(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 255, 250))
    {
        f_e1d427f6(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 251, 254))
    {
        f_5a5f3d08(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 251, 250))
    {
        f_d2464ffa(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 247, 254))
    {
        f_0afec71a(vertex);
        return;
    }

    
    if(iColor==ivec3(230, 247, 250))
    {
        f_2fcac5a9(vertex, .5);
        return;
    }

    
    

    
    
    
    if(iColor==ivec3(255, 255, 254))
    {
        f_ca526293(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 253))
    {
        f_e1d427f6(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 25))
    {
        f_5a5f3d08(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 255, 251))
    {
        f_d2464ffa(vertex);
        return;
    }

    
    if(iColor==ivec3(255, 254, 254))
    {
        f_0afec71a(vertex);
        return;
    }
    

    
    f_4b6881fa(vertex);
    f_0fd8035b();
    finalize();
}