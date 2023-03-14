function linreg(xtx3, xty3) {
  console.log("I got xtx3='"+xtx3+"' and xty3='"+xty3+"'");

  let xtx2 = xtx3.split(" ").map(i=>Number(i));
  let xty2 = xty3.split(" ").map(i=>Number(i));

  // n obs, p vars, r registries
  // xtx2 is p x p x r
  // xty2 is p x 1 x r
  let p = xtx2.length / xty2.length;
  let r = xty2.length / p;

  // Join xtx matrices
  let xtx = [];
  for(let i = 0; i < p; i++) {
    for(let j = 0; j < p; j++) {
      xtx[i + j*p] = 0.0;
      for(let rr = 0; rr < r; rr++) {
        xtx[i + j*p] += xtx2[rr*p*p + i + j*p];
      }
    }
  }

  // Join xty vectors
  let xty = [];
  for(let i = 0; i < p; i++) {
    xty[i] = 0.0;
    for(let rr = 0; rr < r; rr++) {
      xty[i] += xty2[rr*p + i];
    }
  }

  console.log("Have p="+p+" and r="+r+". Combined xtx='"+xtx+"' and xty='"+xty+"'");
  return("xtx <- matrix(c("+xtx+"), nrow = "+p+"); xty <- c("+xty+"); solve(xtx)%*%xty;");
}

function linreg_xtx(xx, yy) {
  // NB x will come in ROW MAJOR!
  let x2 = xx.split(" ").map(i=>Number(i));
  let y = yy.split(" ").map(i=>Number(i));

  console.log("HELLO!");
  console.log("I got xx='"+xx+"' and yy='"+yy+"'");
  console.log("Length of x: "+x2.length);
  console.log("Length of y: "+y.length);

  if(x2.length%y.length != 0) {
    console.log("  ERROR: length of y does not divide length of x");
  }

  let n = y.length;
  let p = x2.length/y.length + 1; // +1 for intercept

  // Make column major x for convenience, adding col of 1's for intercept
  // (terrible for performance! good for sanity!)
  let x = [];
  for(let i = 0; i < n; i++) {
    x[i] = 1.0;
    for(let j = 1; j < p; j++) {
      x[i + j*n] = x2[i*(p-1) + (j-1)];
    }
  }

  let xtx = []; // p x p

  for(let i = 0; i < p; i++) {
    for(let j = 0; j < p; j++) {
      xtx[i + j*p] = 0.0;
      for(let k = 0; k < n; k++) {
        xtx[i + j*p] += x[k + i*n] * x[k + j*n];
      }
    }
  }

  return(xtx.map(i=>String(i)).join(" "));
}

function linreg_xty(xx, yy) {
  // NB x will come in ROW MAJOR!
  let x2 = xx.split(" ").map(i=>Number(i));
  let y = yy.split(" ").map(i=>Number(i));

  console.log("HELLO!");
  console.log("I got xx='"+xx+"' and yy='"+yy+"'");
  console.log("Length of x: "+x2.length);
  console.log("Length of y: "+y.length);

  if(x2.length%y.length != 0) {
    console.log("  ERROR: length of y does not divide length of x");
  }

  let n = y.length;
  let p = x2.length/y.length + 1; // +1 for intercept

  // Make column major x for convenience, adding col of 1's for intercept
  // (terrible for performance! good for sanity!)
  let x = [];
  for(let i = 0; i < n; i++) {
    x[i] = 1.0;
    for(let j = 1; j < p; j++) {
      x[i + j*n] = x2[i*(p-1) + (j-1)];
    }
  }

  let xty = []; // p x 1

  for(let i = 0; i < p; i++) {
    xty[i] = 0.0;
    for(let k = 0; k < n; k++) {
      xty[i] += x[k + i*n] * y[k];
    }
  }

  return(xty.map(i=>String(i)).join(" "));
}
