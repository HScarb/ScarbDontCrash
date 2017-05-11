
require("SoundManager")

local FlashScene = class("FlashScene", function()
    return cc.Scene:create()
end)

function FlashScene:ctor()
    self.size = cc.Director:getInstance():getWinSize()
end

function FlashScene:create()
    local flashScene = FlashScene:new()
    local layer = flashScene:createLayer()
    flashScene:addChild(layer)

    SoundManager:preloadEffect()

    SoundManager:playBg()
    return flashScene
end

function FlashScene:createLayer()
    local layer = cc.Layer:create()

    -- 动作回调函数
    local action_callback = function()
        --cc.Director:getInstance():replaceScene(require("MainGameScene"):create())
    end

    local logo = cc.Sprite:create("logo.png")
    logo:setPosition(self.size.width / 2, self.size.height / 2)
    logo:setScale(0.1)
    layer:addChild(logo)

    -- title 执行动作
    local title_callback = function()
        local title = { }
        local jumpBy = cc.JumpBy:create(1.5, cc.p(0, 0), self.size.height * 0.1, 5)
        local move = cc.MoveBy:create(1.5, cc.p(- self.size.width * 0.8, 0))
        local title_action = cc.Spawn:create(jumpBy, move)

        for i, v in pairs( { "奔", "跑", "吧", "新", "娘" }) do
            title[i] = cc.Label:createWithBMFont("fonts/1.fnt", v)
            title[i]:setPosition(self.size.width + self.size.width * 0.1 * i, self.size.height * 0.5)
            layer:addChild(title[i])
        end

        local index = 1
        local index_callback
        index_callback = function()
            index = index+1
            if index ~= table.getn(title) then
                title[index]:runAction(cc.Sequence:create(title_action,cc.CallFunc:create(index_callback)))
            else
                title[index]:runAction(cc.Sequence:create(title_action,cc.DelayTime:create(1),cc.CallFunc:create(action_callback)))
            end
        end
        title[index]:runAction(cc.Sequence:create(title_action,cc.CallFunc:create(index_callback)))
    end

    -- logo 执行一个淡入淡出的动作
    local scale = cc.EaseElasticOut:create(cc.ScaleTo:create(2, 1.5))
    local action = cc.Sequence:create(scale, cc.FadeOut:create(1), cc.CallFunc:create(title_callback))
    logo:runAction(action)

    -- particle
    local particleSystemQuad = cc.ParticleSystemQuad:create("particle/vanishingPoint.plist")
    particleSystemQuad:setAnchorPoint(cc.p(0.5, 0.5))
    particleSystemQuad:setPosition(cc.p(self.size.width / 2, self.size.height))
    layer:addChild(particleSystemQuad)

    return layer
end

return FlashScene