#include "CicleBy.h"

USING_NS_CC;

CircleBy* CircleBy::create(float tm, cocos2d::Vec2 circleCenter, float sumDegree)
{
	CircleBy *pRet = new CircleBy();
	pRet->init(tm, circleCenter, sumDegree);
	pRet->autorelease();

	return pRet;
}

bool CircleBy::init(float tm, cocos2d::Vec2 circleCenter, float sumDegree)
{
	// 动作执行时间
	if(initWithDuration(tm))
	{
		_originCenter = circleCenter;
		_radius = sqrt(pow(_originCenter.x, 2) + pow(_originCenter.y, 2));
		_sumDegree = -sumDegree / 360 * 2 * M_PI;
		_degree = (Director::getInstance()->getAnimationInterval()) * _sumDegree / tm;
		_times = 1;
		_beginDegree = M_PI + atan2f(_originCenter.y, _originCenter.x);

		return true;
	}
	return false;
}

void CircleBy::update(float dt)
{
	auto degree = _degree * _times + _beginDegree;
	auto x = _radius * cos(degree);
	auto y = _radius * sin(degree);

	_target->setPosition(Vec2(x + _circleCenter.x, y + _circleCenter.y));

	_times++;

	/* 以下代码将圆周运动的轨迹绘制了出来 */
	auto draw = DrawNode::create();
	_target->getParent()->addChild(draw);
	draw->drawDot(_target->getPosition(), 1, Color4F(1, 1, 1, 1));
}

void CircleBy::startWithTarget(cocos2d::Node* target)
{
	ActionInterval::startWithTarget(target);

	if (_times == 1 && (int)_sumDegree % 360 == 0)
		_circleCenter = _originCenter + target->getPosition();
	else
		_circleCenter = _originCenter + target->getPosition();
	_times = 1;
}

CircleBy* CircleBy::reverse() const
{
	return CircleBy::create(_duration, _originCenter, _sumDegree * 360 / (2 * M_PI));
}

CircleBy* CircleBy::clone() const
{
	CircleBy *pRet = new CircleBy();
	pRet->init(_duration, _originCenter, -_sumDegree * 360 / (2 * M_PI));
	pRet->autorelease();
	return pRet;
}
