var fires=[];
var url=window.location.href;
var urlShort="";

//Fonction pour le chargement 
function initLoad()
{   
    // Récuperation des camions via api
    fetch("http://indolencia.com:10501/Emergency-db/Truck").then(response => response.json()).then(response => {
        truck=response;
        fetch("http://indolencia.com:10501/Simulateur-db").then(response => response.json()).then(response => {
        fires=response;
        console.log(fires)
        chargementTemplate();
	});
	});

    setTimeout(function(){
        window.location.reload(1);
     }, 5000);
}

//Fonction pour le chargement des templates
function chargementTemplate()
{   

    //Récupération des modeles
    var templateDotFire = document.querySelector("#templateDotFire");
    var templateMessage = document.querySelector("#templateFire");
    let left = document.getElementById("mapdiv").offsetLeft + 10
    let top = document.getElementById("mapdiv").offsetTop + 10
    let right = left + 1270
    let down = top + 710
    intervalx = (right - left) / 10
    intervaly = (down - top) / 6

    //Pour chaque feu 
	for (let [id, value] of Object.entries(fires)) {

        // let nameStatus = value.nameStatus
        let coordX = value.coordX
        let coordY = value.coordY
        let intensity = value.intensity
        let divcoordX = coordX * intervalx + left 
        let divcoordY = coordY * intervaly + top

        //On prépare le modele du point de feu 
        let cloneDotFire = document.importNode(templateDotFire.content, true);   
        cloneDotFire=prepareClone(cloneDotFire,id,divcoordX,divcoordY,"absolute", 14 * intensity, 14 * intensity);
        document.getElementById('containeFire').appendChild(cloneDotFire);

        //On prépare le modele du message du feu 
        let cloneMessage = document.importNode(templateMessage.content, true);  
        cloneMessage=prepareClone(cloneMessage,"",divcoordX,divcoordY,"absolute","","");
        cloneMessage.firstElementChild.innerHTML = cloneMessage.firstElementChild.innerHTML
			.replace(/{{longitude}}/g, coordX)		
            .replace(/{{latitude}}/g, coordY)
            .replace(/{{intensity}}/g, intensity)
            .replace(/{{monId}}/g, id);
        document.getElementById('containeFire').appendChild(cloneMessage);
    };
    for (let [id, value] of Object.entries(truck)) {
        let coordX = value.coordX
        let coordY = value.coordY
        let divcoordX = coordX * intervalx + left 
        let divcoordY = coordY * intervaly + top

        console.log('CoordX -> ' + coordX)
        console.log('CoordY -> ' + coordY)
        console.log('CoordX -> ' + divcoordX)
        console.log('divCoordY -> ' + divcoordY)

        let cloneDotTruck = document.importNode(templateDotTruck.content, true);
        cloneDotTruck=prepareClone(cloneDotTruck,id,divcoordX,divcoordY,"absolute", 15, 15);
        console.log(cloneDotTruck);
        document.getElementById('containeFire').appendChild(cloneDotTruck);
    };
}

function prepareClone(clone,id,left,top,position,height,width){
    clone.firstElementChild.style.left=left+"px";
    clone.firstElementChild.style.top=top+"px";
    clone.firstElementChild.style.position=position;

    if (id!==""){
        clone.firstElementChild.id="id"+id;
    }
    if (height!==""){
        clone.firstElementChild.style.height=height+"px";
    }
    if (width!==""){
        clone.firstElementChild.style.width=width+"px";
    }
    return clone;
}














