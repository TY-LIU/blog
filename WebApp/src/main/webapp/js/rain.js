function getRgb(r, g, b) {
    return "rgb(" + r + "," + g + "," + b + ")";
}

function main(flag) {
    var canvasEl = document.getElementById('canvas');
    var ctx = canvasEl.getContext('2d');
    if (!flag) {
        canvasEl.parentNode.removeChild(canvasEl);
        return false;
    }
    //drop来存放溅射的雨滴
    var dropList = [];
    //重力因素，保持溅射的雨滴不会飞远
    var gravity = 0.8;
    //保存雨滴
    var linelist = [];

    //鼠标的开始点为
    var mousePos = [0, 0];
    var backgroundColor = '#fff';
    canvasEl.width = canvasEl.clientWidth;
    canvasEl.height = canvasEl.clientHeight;

    var speedx = 0;
    var maxspeedx = 0;

    //当改变浏览器窗口大小时
    window.onresize = function () {
        canvasEl.width = canvasEl.clientWidth;
        canvasEl.height = canvasEl.clientHeight;
    };
    //当鼠标移动时，获取坐标
    window.onmousemove = function (e) {
        mousePos[0] = e.clientX;
        mousePos[1] = e.clientY;
        //最大速度-1到1个屏幕
        maxspeedx = (e.clientX - canvasEl.clientWidth / 2) / (canvasEl.clientWidth / 2);

    };

    //给单个雨滴加属性
    function createLine(e) {
        //长度在12.5-37.5之间
        var temp = 1 * ( 50 + Math.random() * 100);
        //速度在16.5-50.5之间
        var myline = {
            speed: 3.5 * (Math.random() * 6 + 3),
            die: false,
            posx: e,
            posy: -200,
            h: temp,
            //颜色在
            color: (getRgb(Math.floor(temp * 255 / 75), Math.floor(temp * 255 / 75), Math.floor(temp * 255 / 75)))
        };
        //添加到数组中
        linelist.push(myline);
    }

    update();

    //生产小雨滴
    function createDrop(x, y) {
        var mydrop = {
            die: false,
            //溅射x坐标
            posx: x,
            //溅射的y坐标
            posy: y,
            //随机生成一个x轴速度
            vx: (Math.random() - 0.5) * 8,
            //随机生成一个y轴速度
            vy: Math.random() * (-6) - 3,
            radius: Math.random() * 1.5 + 1
        };
        return mydrop;
    }

    //溅射效果
    function madedrops(x, y) {
        //溅射的雨滴数为5-10滴
        var maxi = Math.floor(Math.random() * 5 + 5);
        for (var i = 0; i < maxi; i++) {

            dropList.push(createDrop(x, y));
        }
    }

    function update() {

        //循环遍历小雨滴，显示溅射的雨滴，移除超出范围的雨滴
        if (dropList.length > 0) {
            dropList.forEach(function (e) {
                //小雨滴的x轴速度=随机速度+雨滴初始速度
                e.vx = e.vx + (speedx) / 2;
                //小雨滴的新坐标
                e.posx = e.posx + e.vx;
                //小雨滴的y轴速度=随机速度+重力
                e.vy = e.vy + gravity;
                e.posy = e.posy + e.vy;

                //雨滴超出屏幕高度，则消失
                if (e.posy > canvasEl.clientHeight) {
                    e.die = true;
                }
            });
        }

        //移除超出范围的雨滴
        for (var i = dropList.length - 1; i >= 0; i--) {
            if (dropList[i].die) {
                dropList.splice(i, 1);
            }
        }
        //鼠标的位置控制雨的速度
        //当鼠标在中间maxspeedx为0，不倾斜，速度不加快

        speedx = speedx + (maxspeedx - speedx) / 50;

        if (Math.random() > 0) {
            //雨滴的出生点的X轴坐标在-0.5到1.5倍的屏幕,这样雨滴倾斜的时候，最角落也会有雨滴
            createLine(Math.random() * 1.5 * canvasEl.width - Math.random() * 0.5 * canvasEl.width);
            createLine(Math.random() * 1.5 * canvasEl.width - Math.random() * 0.5 * canvasEl.width);

            createLine(Math.random() * 1.5 * canvasEl.width - Math.random() * 0.5 * canvasEl.width);
        }

        //雨滴到达近地面时，近地面（1到0.8的屏幕高度）
        var mydeadline = canvasEl.clientHeight - Math.random() * canvasEl.clientHeight / 5;

        //监听雨滴，雨滴距离鼠标的直线距离小于35时，两点之间的距离公式
        linelist.forEach(function (e) {

            //雨滴距离鼠标的直线距离小于35时，两点之间的距离公式
            var dis = Math.sqrt(((e.posx + speedx * e.h) - mousePos[0]) * ((e.posx + speedx * e.h) - mousePos[0]) + (e.posy + e.h - mousePos[1]) * (e.posy + e.h - mousePos[1]));
            if (dis < 35) {
                //雨滴消失，产生小雨滴
                madedrops(e.posx + speedx * e.h, e.posy + e.h);
                e.die = true;
            }

            //当雨滴到达地面时，每个雨滴的地面不同，0.8到1个屏幕高度
            //如果每个
            if ((e.posy + e.h) > mydeadline) {

                //每个雨滴都出水花太多了。给个0.9的概率
                if (Math.random() > 0.9) {
                    madedrops(e.posx + speedx * e.h, e.posy + e.h);
                    e.die = true;
                }
            }
            //水滴超出屏幕高度，设置为消失
            if (e.posy >= canvasEl.clientHeight) {
                e.die = true;
            } else {
                e.posy = e.posy + e.speed;
                e.posx = e.posx + (e.speed * speedx);
            }
        });

        //消失雨滴
        for (var i = linelist.length - 1; i >= 0; i--) {
            if (linelist[i].die) {
                linelist.splice(i, 1);
            }
        }
        //清除界面
        render();
        //重绘页面
        window.requestAnimationFrame(update);
    }

    function render() {
        ctx.fillStyle = backgroundColor;
        ctx.background = "Transparent";
        ctx.fillRect(0, 0, canvasEl.width, canvasEl.height);

        linelist.forEach(
            //绘制雨滴
            function (line) {
                ctx.strokeStyle = line.color;

                ctx.lineWidth = 4.5;
                ctx.beginPath();
                ctx.moveTo(line.posx, line.posy);
                ctx.lineTo(line.posx + speedx * line.h, line.posy + line.h);
                ctx.stroke();
            });

        ctx.lineWidth = 1;
        ctx.strokeStyle = "#91c1ff";

        //绘制溅射雨滴
        dropList.forEach(function (e) {
            ctx.beginPath();
            ctx.arc(e.posx, e.posy, e.radius, Math.random() * Math.PI * 2, 1 * Math.PI);
            ctx.stroke();
        });
    }
}