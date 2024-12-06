// https://github.com/becojo/daggerverse/tree/main/processing
///////////////////////////////////////////////////////////////////////////////////
int frames = 30;           // number of frames per period
float period = TWO_PI;     // period of the animation
boolean preload = false;   // run the sketch for 1 period before starting to record
int periods = 200;           // number of periods to record
///////////////////////////////////////////////////////////////////////////////////

import java.util.Map;

HashMap<String, String> hm = new HashMap<String, String>();
float size;
int mapWidth, mapHeight;
int dx = 0, dy = -1;
int gx, gy;
boolean done = false;
int count = 0;
boolean shouldExit = false;


char mapGet(int x, int y) {
    String key = String.format("%d,%d", x, y);
    if (!hm.containsKey(key)) return 0;
    return hm.get(key).charAt(0);
}

void setup() {
    if(!record) frameRate(100);

    String[] lines = loadStrings("6-test");
    for (int i = 0; i < lines.length; i++) {
        for (int j = 0; j < lines[i].length(); j++) {
            char c = lines[i].charAt(j);
            if (c == '\n') continue;
            String key = String.format("%d,%d", j, i);
            hm.put(key, String.valueOf(c));
            if(c == '^') {
                gx = j;
                gy = i;
            }
        }
    }
    mapWidth = lines[0].length();
    mapHeight = lines.length;

    size = width * 0.8 / mapWidth;
    textSize(24); 

}

void render(float r) {
    background(0);

    translate(width / 2 - mapWidth / 2 * size, height / 2 - mapHeight / 2 * size);

    fill(255);
    text(String.format("count: %d", count), -0, -20);
    

    for(int x = 0; x < mapWidth; x++) {
        for(int y = 0; y < mapHeight; y++) {
            String key = String.format("%d,%d", x, y);
            String value = hm.get(key);
        
            if (value == null) continue;

            switch(value) {
                case "#":
                    fill(255, 0, 0);
                    break;
                case "^":
                    fill(0, 255, 0);
                    break;
                case ".": 
                    fill(30);
                    break;
                case "V":
                    fill(0, 0, 255);
                    break;
                case "C":
                    fill(0, 0, 100);
                    break;
            }
            
            rect(x * size, y * size, size, size);
        }
    }

    
    if(!done) {
        hm.put(String.format("%d,%d", gx, gy), "V");
        gx += dx;
        gy += dy;
    }

    char c = mapGet(gx, gy);
    switch (c) {
    case '#':
        gx -= dx;
        gy -= dy;

        int tmp = dx;
        dx = -dy;
        dy = tmp;

        gx += dx;
        gy += dy;
        break;
    case 0:
        done = true;
        break;

    }
    if (!done) {
        hm.put(String.format("%d,%d", gx, gy), "^");
    }

    if(shouldExit) {
        exit();
    }

    if(done) {
        String key = null, value = null;
        boolean found = false;
        for(int i = 0; i < mapWidth * mapHeight; i++) {
            key = String.format("%d,%d", i % mapWidth, i / mapWidth);
            value = hm.get(key);
            if(value == null) continue;
            if(value.equals("V")) {
                count += 1;
                found = true;
                break;
            }
        }
        if(found)  {
            hm.put(key, "C");
        }

        if(!found) {
            shouldExit = true;
            println(frameCount);
        }
    }    
}
