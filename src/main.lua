
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"

-- cclog
cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    return msg
end

local function main()
    collectgarbage("collect")
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    cc.FileUtils:getInstance():addSearchPath("src")
    cc.FileUtils:getInstance():addSearchPath("res")
    cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(480, 320, 0)

    local pOpenGLView = cc.Director:getInstance():getOpenGLView()
    local frameSize = pOpenGLView:getFrameSize()

    local winSize = {width = 1280, height = 720}

    local widthRate = frameSize.width/winSize.width
    local heightRate = frameSize.height/winSize.height

    if widthRate > heightRate then
        pOpenGLView:setDesignResolutionSize(winSize.width, winSize.height * heightRate / widthRate , 1)
    else
        pOpenGLView:setDesignResolutionSize(winSize.width  * widthRate / heightRate, winSize.height, 1)
    end

    local flashScene = require("FlashScene").create()
    --local scene = require("FlashScene")
    --local gameScene = scene.create()
    
    print("running scene: ", cc.Director:getInstance():getRunningScene())
    if cc.Director:getInstance():getRunningScene() then
    --    print("replace scene")

        cc.Director:getInstance():replaceScene(flashScene)
    else
    --    print("run with scene")
        cc.Director:getInstance():runWithScene(flashScene)

    end

end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end