/**
 * id
 * 百分百
 * x轴 y轴
 * 圆的半径
 * 弧宽
 * 边框底色
 * 底色
 * 染色
 * 渲染速度
 * 字体颜色
 * 字体大小
 * */
function startCircle(_id, percent, x, y, r, lineWidth, ground, bgColor, tincture, spend, fontCor, fontSize) {
    var c = document.getElementById(_id);
    var n = 0;
    var percent = percent;
    var ctx = c.getContext("2d");

    //渲染边框底图
    function fillBorder() {
        /*ctx.scale(2,2);*/
        ctx.beginPath();
        ctx.lineWidth = lineWidth;
        ctx.strokeStyle = ground;
        ctx.arc(x, y, r, 0, 2 * Math.PI);
        ctx.stroke();
    }

    //渲染底图
    function fillBG() {
        /*ctx.scale(2,2);*/
        ctx.beginPath();
        ctx.fillStyle = bgColor;
        ctx.arc(x, y, r, 0, 2 * Math.PI);
        ctx.fill();
        ctx.stroke();
    }

    //渲染着色区
    function fillArc(num) {
        /*ctx.scale(2,2);*/
        ctx.beginPath();
        ctx.lineWidth = lineWidth;
        ctx.strokeStyle = tincture;
        ctx.arc(x, y, r, -90 * Math.PI / 180, (num * 3.6 - 90) * Math.PI / 180);
        ctx.stroke();

    }

    //渲染字体
    function fillText(num) {
        /*ctx.scale(2,2);*/
        ctx.beginPath();
        ctx.font = "" + fontSize + "px Arial";
        ctx.fillStyle = fontCor;
        ctx.textBaseline = "middle";
        ctx.textAlign = "center";
        ctx.fillText(num, x - fontSize / 3, y);
        ctx.font = "" + fontSize - 15 + "px Arial";
        ctx.fillText("%", x + fontSize / 2, y + 4);
        ctx.stroke();
    }

    //全区渲染
    function fill(x) {
        fillBorder();
        fillBG();
        fillArc(x);
        fillText(x);
    }

    //清除渲染
    function clearCircle() {
        ctx.clearRect(0, 0, 2 * x, 2 * y);
    }

    loadYuan();

    //开始渲染
    function loadYuan() {
        if (n == 1)
            ctx.scale(2, 2);
        if (++n > percent) {
            return false;
        }
        clearCircle();
        fill(n);
        setTimeout(loadYuan, spend);
    }
}